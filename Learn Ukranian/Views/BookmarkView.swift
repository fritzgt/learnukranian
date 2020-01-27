//
//  BookmarkView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/25/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import SwiftUI


struct BookmarkView: View {
    //    //Use to Create items in CoreData
    //    @Environment(\.managedObjectContext) var moc
    
    //Use to read CoreData
    @FetchRequest(entity: Posts.entity(), sortDescriptors: []) var posts: FetchedResults<Posts>
    
    //for deleting bookmark
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack {
            Text("Bookmarks").font(.title)
            List {
                ForEach(posts, id: \.id) {post in
                    HStack{
                        //                        Text(post.title ?? "unknonwn")
                        Image(systemName:post.image ?? "None")
                            .font(.system(size: 35))
                            .aspectRatio(contentMode: .fill)
                        //                    .frame(height:65)
                        Text(post.title ?? "None")
                        Spacer()
                        
                        //2nd column inside cell
                        VStack{
                            Text(post.trans ?? "None").bold()
                            Spacer()
                            Text(post.pron ?? "None")
                        }
                    }.padding()//use to add padding since background is a
                }
                .onDelete(perform: removeBookmark)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.blue)
                ).foregroundColor(.white)
            }
        }
    }
    
    func removeBookmark(at offsets: IndexSet){
        for index in offsets{
            let bookmark = posts[index]
            managedObjectContext.delete(bookmark)
            
            //Save data
            do{
                try managedObjectContext.save()
            }catch{
                print("Error saving to CoreData \(error)")
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
