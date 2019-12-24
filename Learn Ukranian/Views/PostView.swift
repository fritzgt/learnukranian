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
    
   
    
    @State var title: String = ""
    @State var trans: String = ""
    @State var pron: String = ""
    @State var image: String = ""
    @State var catid: String = ""
    @State var subcat = true
    
    
    var body: some View {
        
        VStack{
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
                    //Submit
                    Button(action: {
                        self.postData()
                    }){
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                    }
                }
            }
        }
    }
    
    func postData(){
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
                    self.title = "";
                    self.trans = "";
                    self.pron = "";
                    self.image = "";
                    self.catid  = ""
                }
                
            }
        }
    }//end of postData func
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
