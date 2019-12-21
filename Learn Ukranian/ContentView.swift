//
//  ContentView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/20/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        //Enable NavBar 
        NavigationView {
            
            //Vertical stack for alyout view
            VStack{
                
                //Main banner image
                Image("lviv")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:270)
                    .cornerRadius(15)
                
                //List of categories to choose from
                List(CatList){post in
                    Image(systemName:post.image)
                    Text(post.title)
                }
                //Welcome title on top of the page
                .navigationBarTitle("Welcome")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
