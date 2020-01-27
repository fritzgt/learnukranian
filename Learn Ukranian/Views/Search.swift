//
//  Search.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/26/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import SwiftUI

struct Search: View {
    
    //For the search field
    @State private var search: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass").font(.title)
                Text("Search").font(.title)
                
            }.padding()
            TextField("Search", text: $search)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            List{
                VStack{
                    Text("Results...")
                }
            }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
