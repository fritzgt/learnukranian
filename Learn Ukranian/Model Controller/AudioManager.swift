//
//  AudioManager.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/28/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation
//to transcript from audio to text
import Speech

//API to translate text
import Firebase



class ClosedCaptioning: ObservableObject{
    //set lenguage
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let translator: Translator
    
    @Published var captioning: String = "Tap mic to Start!"
    @Published var translation: String = ""
    @Published var isPlaying: Bool = false
    @Published var micEnabled: Bool = false
    
    //Initiating Firebase translation uk = Ukranian
    init (){
      let options = TranslatorOptions(sourceLanguage: .en, targetLanguage: .uk)
      translator = NaturalLanguage.naturalLanguage().translator(options: options)
      translator.downloadModelIfNeeded { (error) in
        guard error == nil else { return }
        self.micEnabled = true
      }
    }
    
    //Thanks to https://developer.apple.com/documentation/speech/recognizing_speech_in_live_audio
    func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                // ***We will update State here!***
                // ??? = result.bestTranscription.formattedString
                isFinal = result.isFinal
//
                //English Text
                self.captioning = result.bestTranscription.formattedString
                
                
                //Translating text
                self.translator.translate(result.bestTranscription.formattedString) { (translatedText, error) in
                    guard error == nil,
                        let translatedText = translatedText
                        else { return }
                    //Output of translated text
                    self.translation = translatedText
                }
                
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func micButtonTapped(){
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            isPlaying = false
        } else {
            do {
                try startRecording()
                isPlaying = true
            } catch {
                isPlaying = false
            }
        }}
}


