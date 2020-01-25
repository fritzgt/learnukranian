//
//  ContentView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/20/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //Use for the add modal to be invoke or dismiss
    @State private var show_modal: Bool = false
    
    @State var selectedView = 0
    
    @State private var search: String = ""
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        //Enable NavBar
        
        VStack {
            TabView(selection: $selectedView){
                HStack {
                    NavigationView {
                        //Vertical stack for layout view
                        VStack{
                            //Search field
                            //                            TextField("Search", text: $search)
                            //                                .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                            List(networkManager.dataCat){post in
                                //Creating links to take user to subcategories
                                NavigationLink(destination: CatView(catId: post.catid)) {
                                    ZStack {
                                        //Main banner image
                                        Image(post.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height:200)
                                            .cornerRadius(20)
                                        Text(post.title)
                                            .font(.largeTitle)
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                            .padding(.horizontal, 75)
                                            .background(Color.black.opacity(0.5))
                                            .foregroundColor(.white)
                                    }
                                }
                                    //Welcome title on top of the page
                                    .navigationBarTitle(K.bannerTItle)
                                    .navigationBarItems(trailing:
                                        Button(action: {
                                            self.show_modal = true
                                        }) {
                                            Image(systemName: "plus").imageScale(.large)
                                        }.sheet(isPresented: self.$show_modal) {
                                            PostView(post: nil)
                                        }
                                )
                                
                            }
                            
                        }//1st vstack ends
                        
                    }
                        //When view loads will call the loadData method
                        .onAppear{
                            self.networkManager.createQuery(collection: "categories", id: nil)
                            //set the separator line to clear on the list
                            UITableView.appearance().separatorColor = .clear
                    }
                }//end of 2nd vstack
                    .tabItem {
                        Image(systemName: "bubble.left")
                        Text("Home")
                }.tag(0)
                //Second View (BOOKMARKS)
                Text("Translate")
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
                Text("Settings View")
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                }.tag(3)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
