//
//  ExploreViewModel.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 28/01/2025.
//


import SwiftUI

struct ExploreCategoryModel: Identifiable, Equatable {
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var color: Color = Color.primaryApp

    init(dict: NSDictionary) {
        self.id = dict["cat_id"] as? Int ?? 0
        self.name = dict["cat_name"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.color =  Color(hex: dict["color"] as? String ?? "000000")

    }
    
    static func == (lhs: ExploreCategoryModel, rhs: ExploreCategoryModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}


