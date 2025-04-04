//
//  TypeModel.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 25/01/2025.
//

import SwiftUI

struct CategoryModel: Identifiable, Equatable {
    
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var colorStr: String = ""
    var color: Color = Color.primaryApp
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "cat_id") as? Int ?? 0
        self.name = dict.value(forKey: "cat_name") as? String ?? "BBBBBB"
        self.colorStr = dict.value(forKey: "color") as? String ?? ""
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.color = Color(hex: dict.value(forKey: "color") as? String ?? "000000")
       
    }
    
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.id == rhs.id
    }
}
