//
//  BookmarkView.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 1/25/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import SwiftUI

struct BookmarkView: View {
    var body: some View {
        VStack {
            Text("Bookmarks").font(.title)
            List {
                Text("Empty List")
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
