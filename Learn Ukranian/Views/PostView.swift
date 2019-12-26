//
//  PostView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/23/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import SwiftUI

// 1. Import FireBase
import Firebase

struct PostView: View {
    
    //data comming to be edited
    let post:  Categories?
    
    //Use for modal to be dismiss after submit
    @Environment(\.presentationMode) var presentationMode
    
    //Textfield variables
    @State var title: String = ""
    @State var trans: String = ""
    @State var pron: String = ""
    @State var image: String = ""
    @State var catid: String = ""
    @State var subcat = true
    
    
    var body: some View {
        
        
        VStack{
            Text("Create / Edit").padding()
            //input
            
            Form {
                TextField("Title", text: $title)
                TextField("Trans", text: $trans)
                TextField("Pron", text: $pron)
                TextField("Image", text: $image).autocapitalization(.none)
                TextField("Catid", text: $catid).autocapitalization(.none)
                Toggle(isOn: $subcat) {
                    Text("SubCat")
                }
                //Preview
                VStack{
                    Text("Preview")
                    HStack{
                        Image(systemName:image)
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                        Text(title)
                            .font(.system(size: 18))
                        Spacer()
                        VStack{
                            Text(trans)
                                .font(.system(size: 18))
                                .padding(.bottom, 10)
                            Text(pron)
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                        
                    }
                    .padding()
                    .border(Color.gray, width: 2)
                    
                    
                    //Submit
                    //if post exist its from edit else is adding a new item
                    Button(action: {
                        if (self.post != nil) {
                            self.edit(id: self.post!.id)
                        }else {
                            self.postData()
                        }
                        
                        //Use for modal to be dismiss after submit
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                    }
                }
            }
        }//
            .onAppear(perform: defaultValues)
    }
    
    //prepopulate fields
    func defaultValues() {
        if post != nil {
            self.title = post!.title
            self.trans = post!.trans
            self.pron = post!.pron
            self.image = post!.image
            self.catid  = post!.catid
        }
    }
    
    func postData(){
        print("Post")
        //Initializing Firestore
        let db = Firestore.firestore()
        
        var collectionName: String{
            switch subcat {
            case true:
                return  "subcat"
            default:
                return "categories"
            }
        }
        
        db.collection(collectionName).addDocument(data: [
            "title": title,
            "trans": trans,
            "pron": pron,
            "image": image,
            "catid": catid
            
        ]) { (error) in
            if let e = error{
                print("There was an issue saving data \(e)")
            }else{
                print("Succressfully")
                
                //Clear input field and because is inside a closure
                //we must use DispatchQueue.main.async so the action
                //happens in the foreground instead of the background
                DispatchQueue.main.async {
                    self.title = ""
                    self.trans = ""
                    self.pron = ""
                    self.image = ""
                    self.catid  = ""
                }
            }
        }
    }//end of postData func
    
    //Update method
    func edit(id: String){
        print("Edit")
        
        let db = Firestore.firestore()
        
        // Add a new document in collection "cities"
        db.collection("subcat").document(id).setData([
            "title": title,
            "trans": trans,
            "pron": pron,
            "image": image,
            "catid": catid
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: nil)
    }
}
