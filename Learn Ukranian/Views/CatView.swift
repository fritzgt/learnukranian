//
//  CatView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/21/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct CatView: View {
    
    //Use for the add modal to be invoke or dismiss
    @State private var show_modal: Bool = false
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    

    //get the catid from the selected categorie
    //This will be use to create query
    let catId: String
    
    var body: some View {
        //iterate thru array with a Forech because onDelete
        //is its memeber
        List{ ForEach(networkManager.dataCat, id: \.self) {post in
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
//                    Text(post.pron)
//                        .foregroundColor(.gray)
//                        .font(.system(size: 14))
                    //Create a modal to add new content
                    Button(action: {
                        self.show_modal = true
                        print("Item to be edited \(post)")
                    }) {
                        Text(post.pron)
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }.sheet(isPresented: self.$show_modal) {
                        PostView(post: post )
                    }
                    //End of edit button
                }
            }
            //Creating a closure for delete
            //passing the data array and returning selected item
        }.onDelete {
            self.networkManager.delete(data: $0.map{
                return  self.networkManager.dataCat[$0]
            })
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
