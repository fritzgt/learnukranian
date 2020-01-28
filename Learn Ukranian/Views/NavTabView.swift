//
//  ContentView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/20/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct NavTabView: View {
    
    //Use for the tab bar
    @State var selectedView = 0
    
    
    var body: some View {
        VStack {
            TabView(selection: $selectedView){
                //1st View (Learn)
                LearnMain()
                    .tabItem {
                        Image(systemName: "bubble.left")
                        Text("Learn")
                }.tag(0)
                //Second View (BOOKMARKS)
                Translate()
                    .tabItem {
                        Image(systemName: "mic")
                        Text("Translate")
                }.tag(1)
                //Second View (BOOKMARKS)
                BookmarkView()
                    .tabItem {
                        Image(systemName: "bookmark")
                        Text("Bookmarks")
                }.tag(2)
                //Second View (SETTINGS)
                LearnSettings()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                }.tag(3)
            }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView()
    }
}
