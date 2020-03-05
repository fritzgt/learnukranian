//
//  CatView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/21/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

struct CatView: View {
    
    //MARK: - Properties
    
    
//    Use to Create items in CoreData for Bookmarks
    @Environment(\.managedObjectContext) var moc
    
    
    //Use for the add modal to be invoke or dismiss
    @State private var show_add_modal: Bool = false
    
    @State private var show_edit_modal: Bool = false
    
    //Initialting netWorkManager
    @ObservedObject var networkManager = NetworkManager()
    
    //Use to read CoreData
    @FetchRequest(entity: Posts.entity(), sortDescriptors: []) var corePosts: FetchedResults<Posts>
    
    //get the catid from the selected categorie
    //This will be use to create query
    let catId: String
    
    //MARK: - view
    
    var body: some View {
        List{ ForEach(networkManager.dataCat, id: \.self) {post in
            HStack{
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
                    //Bookmark post on image tap
                    Image(systemName: "bookmark")
                        .onTapGesture {

                            let newBookmark = Posts(context: self.moc)
                            newBookmark.id = post.id
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
                    //Edit mode
                    Image(systemName: "square.and.pencil").onTapGesture {
                        self.show_edit_modal = true
//                        print(post)
                    }.sheet(isPresented: self.$show_edit_modal) {
                        PostView(post: post )
                        
                    }
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
        .navigationBarItems(trailing:
            Button(action: {
                self.show_add_modal = true
            }) {
                Image(systemName: "plus").imageScale(.large).padding()
            }.sheet(isPresented: self.$show_add_modal) {
                PostView(post: nil)
            }
        )
            .navigationBarTitle(catId.capitalized)
    }
    
    
    struct CatView_Previews: PreviewProvider {
        static var previews: some View {
            CatView( catId: "cat1")
        }
    }
    
}
