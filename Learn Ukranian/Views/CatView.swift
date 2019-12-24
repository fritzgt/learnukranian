//
//  CatView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/21/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct CatView: View {
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    
    //get the catid from the selected categorie
    //This will be use to create query
    let catId: String

    var body: some View {
       
        //iterate thru array
        List(networkManager.dataCat){post in
            HStack{
                Image(systemName:post.image)
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                Text(post.title)
                    .font(.system(size: 18))
                    Spacer()
                VStack{
                    Text(post.trans)
                       .font(.system(size: 18))
                        .padding(.bottom, 10)
                    Text(post.pron)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
        }
        .onAppear{
            self.networkManager.createQuery(collection: "subcat", id: self.catId)
        }
    }
    
    
    
    struct CatView_Previews: PreviewProvider {
        static var previews: some View {
            CatView( catId: "cat1")
        }
    }
}
