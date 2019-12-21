//
//  Categories.swift
//  Learn Ukranian
//
//  Created by FGT MAC on 12/21/19.
//  Copyright © 2019 FGT MAC. All rights reserved.
//

import Foundation

//Creating struct for categories blueprint
struct Categories: Identifiable {
    let id: String
    let title: String
    let image: String
}

//Creating array of instances of the struct
let CatList = [
    Categories(id: "1", title: "Time", image: "clock"),
    Categories(id: "2", title: "Numbers", image: "list.number"),
    Categories(id: "3", title: "Greetings", image: "captions.bubble"),
    Categories(id: "4", title: "Weather", image: "cloud.sun"),
    Categories(id: "5", title: "Body Parts", image: "person"),
    Categories(id: "6", title: "Food", image: "cart"),
    Categories(id: "7", title: "Phrases", image: "bubble.left.and.bubble.right"),
    Categories(id: "8", title: "Travel", image: "map"),
    Categories(id: "9", title: "House", image: "house"),
    Categories(id: "10", title: "Bookmark", image: "bookmark"),
    Categories(id: "11", title: "About us", image: "info.circle")
]
