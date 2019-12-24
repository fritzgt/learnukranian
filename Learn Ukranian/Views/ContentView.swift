//
//  ContentView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/20/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        //Enable NavBar 
        HStack {
            NavigationView {
                
                //Vertical stack for alyout view
                VStack{
                    ZStack {
                        //Main banner image
                        Image("lviv")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:230)
                            .cornerRadius(10)
                        Text("K")
                            .font(.largeTitle)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 45)
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        NavigationLink(destination: PostView()) {
                        Text("Post")
                            .foregroundColor(Color.gray)
                        }
                    }
                    //List of categories to choose from
                    List(networkManager.dataCat){post in
                        //Creating links to take user to subcategories
                        NavigationLink(destination: CatView(catId: post.catid)) {
                            HStack {
                                Image(post.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:80)
                                    .cornerRadius(5)
                                VStack{
                                    Text(post.title)
                                        .font(.system(size: 18))
                                    Text(post.trans)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                    Text(post.pron)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                }
                            }
                            
                        }
                            //Welcome title on top of the page
                            .navigationBarTitle("Welcome")
                    }
                }//vstack ends
            }
                //When view loads will call the loadData method
                .onAppear{
                    self.networkManager.createQuery(collection: "categories", id: nil)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
