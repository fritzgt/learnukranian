//
//  Options.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/25/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import SwiftUI

struct Pref {
    let name: String
    let logo: String
    let color: Color
}

struct LearnSettings: View {
    var optionsList = [
        Pref(name: "Sign in", logo: "person.crop.circle.fill", color: .gray),
        Pref(name: "Red Theme", logo: "wand.and.stars", color: .red)
    ]
    
    @State private var theme = true
    
    var body: some View {
        
        
        VStack{
            Text("Settings").font(.title)
            List(){
                ForEach(optionsList,id: \.name) {option in
                    HStack{
                        Image(systemName:option.logo)
                            .foregroundColor(option.color)
                        Toggle(isOn: self.$theme) {
                            Text(option.name).font(.system(size: 16))
                        }
                       
                    }
                }
            }
        }
    }
}

struct Options_Previews: PreviewProvider {
    static var previews: some View {
        LearnSettings()
    }
}
