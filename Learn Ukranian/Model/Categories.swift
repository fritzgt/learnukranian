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
    //Identifiable protocol relies on the id to correctly
    //render items in the array in each List view
    let id: String
    let title: String
    let trans: String
    let pron: String
    let image: String
    let catid: String
}

