//
//  Translate.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/28/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import SwiftUI
import Speech



struct Translate: View {
    
    @ObservedObject var closedCap = ClosedCaptioning()
   
    
    var body: some View {
        VStack {
            Text("Translate").font(.title)
            Spacer()
            Text(self.closedCap.captioning)
            Spacer()
            Button(action: { self.closedCap.micButtonTapped() }) {
                Image(systemName: self.closedCap.isPlaying ? "mic.circle.fill" : "mic.circle").font(.system(size: 75, weight: .thin))
            }
            Spacer()
        }
        .onAppear {
          SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.closedCap.micEnabled = true
                case .denied, .restricted, .notDetermined:
                    self.closedCap.micEnabled = false
                default:
                    self.closedCap.micEnabled = false
              }
        }}}
        
    }
    
    struct Translate_Previews: PreviewProvider {
        static var previews: some View {
            Translate()
        }
    }
}
