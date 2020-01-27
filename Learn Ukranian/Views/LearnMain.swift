//
//  LearnMain.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/27/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import SwiftUI

struct LearnMain: View {
    
    //Use for the add modal to be invoke or dismiss
    @State private var show_modal: Bool = false
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    
    
    var body: some View {
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
                                            //Add new items
        //                                    .navigationBarItems(trailing:
        //                                        Button(action: {
        //                                            self.show_modal = true
        //                                        }) {
        //                                            Image(systemName: "plus").imageScale(.large)
        //                                        }.sheet(isPresented: self.$show_modal) {
        //                                            PostView(post: nil)
        //                                        }
        //                                )
                                            .navigationBarItems(trailing:
                                                Button(action: {
                                                    self.show_modal = true
                                                }) {
                                                    Image(systemName: "magnifyingglass").imageScale(.large).padding()
                                                }.sheet(isPresented: self.$show_modal) {
                                                    Search()
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
    }
}

struct LearnMain_Previews: PreviewProvider {
    static var previews: some View {
        LearnMain()
    }
}
