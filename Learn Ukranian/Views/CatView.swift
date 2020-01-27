//
//  CatView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/21/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct CatView: View {
    //Use to Create items in CoreData for Bookmarks
    @Environment(\.managedObjectContext) var moc
    
    
    //Use for the add modal to be invoke or dismiss
    @State private var show_modal: Bool = false
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    
    //NOT IMPLEMENTED YET
    var isBookmarked: String {
        return "bookmark.fill"
    }
    //get the catid from the selected categorie
    //This will be use to create query
    let catId: String
    
    var body: some View {
        List{ ForEach(networkManager.dataCat, id: \.self) {post in
            HStack{
                //                Button to edit content
                //                Button(action: {
                //                    self.show_modal = true
                //                }) {
                //                     Image(systemName:post.image)
                //                                       .font(.system(size: 35))
                //                                       .aspectRatio(contentMode: .fill)
                //                }.sheet(isPresented: self.$show_modal) {
                //                    PostView(post: post )
                //                }
                Image(systemName:post.image)
                    .font(.system(size: 35))
                    .aspectRatio(contentMode: .fill)
                //                    .frame(height:65)
                Text(post.title)
                Spacer()
                
                //2nd column inside cell
                VStack{
                    Text(post.trans).bold()
                    Spacer()
                    Text(post.pron)
                }
                Spacer()
                //3rd column inside cell
                VStack{
                    Image(systemName: self.isBookmarked)
                        .onTapGesture {
                            let newBookmark = Posts(context: self.moc)
                            newBookmark.id = UUID()
                            newBookmark.image = post.image
                            newBookmark.title = post.title
                            newBookmark.trans = post.trans
                            newBookmark.pron = post.pron
                            //Save data
                            do{
                                try self.moc.save()
                            }catch{
                                print("Error saving to CoreData \(error)")
                            }
                    }
                    Spacer()
                    Image(systemName: "square.and.pencil")
                }
            }.padding()//use to add padding since background is a rectangle
            //Creating a closure for delete
            //passing the data array and returning selected item
        }
        .onDelete {
            self.networkManager.delete(data: $0.map{
                return  self.networkManager.dataCat[$0]
            })
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.red)
        ).foregroundColor(.white)
        }
        .onAppear{
            self.networkManager.createQuery(collection: "subcat", id: self.catId)
            //set the separator line to clear on the list
            //UITableView.appearance().separatorColor = .clear
        }
    }
    
    
    
    
    struct CatView_Previews: PreviewProvider {
        static var previews: some View {
            CatView( catId: "cat1")
        }
    }
}
