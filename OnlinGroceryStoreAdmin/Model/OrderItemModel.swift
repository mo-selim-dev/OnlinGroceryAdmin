//
//  OrderItemModel.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 11/02/2025.
//


import SwiftUI

struct OrderItemModel:  Identifiable, Equatable {
    var id: UUID = UUID()
    var prodId: Int = 0
    var catId: Int = 0
    var brandId: Int = 0
    var typeId: Int = 0
    var orderId: Int = 0
    var qty: Int = 0
    var detail: String = ""
    var name: String = ""
    var unitName: String = ""
    var unitValue: String = ""
    var nutritionWeight: String = ""
    var image: String = ""
    var catName: String = ""
    var typeName: String = ""
    var offerPrice: Double?
    var itemPrice: Double = 0.0
    var totalPrice: Double = 0.0
    var price: Double = 0
    var startDate: Date = Date()
    var endDate: Date = Date()
    var isFav: Bool = false
    var rating: Int = 0
    var message: String = ""
    

    init(dict: NSDictionary) {
        
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.catId = dict.value(forKey: "cat_id") as? Int ?? 0
        self.brandId = dict.value(forKey: "brand_id") as? Int ?? 0
        self.typeId = dict.value(forKey: "type_id") as? Int ?? 0
        self.orderId = dict.value(forKey: "order_id") as? Int ?? 0
        self.qty = dict.value(forKey: "qty") as? Int ?? 0
        self.isFav = dict.value(forKey: "is_fav") as? Int ?? 0 == 1
        
        self.detail = dict.value(forKey: "detail") as? String ?? ""
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.unitName = dict.value(forKey: "unit_name") as? String ?? ""
        self.unitValue = dict.value(forKey: "unit_value") as? String ?? ""
        self.nutritionWeight = dict.value(forKey: "nutrition_weight") as? String ?? ""
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.catName = dict.value(forKey: "cat_name") as? String ?? ""
        self.typeName = dict.value(forKey: "type_name") as? String ?? ""
        self.offerPrice = dict.value(forKey: "offer_price") as? Double
        self.price = dict.value(forKey: "price") as? Double ?? 0
        self.itemPrice = dict.value(forKey: "item_price") as? Double ?? 0
        self.totalPrice = dict.value(forKey: "total_price") as? Double ?? 0
        self.startDate = (dict.value(forKey: "start_date") as? String ?? "").stringDateToDate() ?? Date()
        self.endDate = (dict.value(forKey: "end_date") as? String ?? "").stringDateToDate() ?? Date()
        
        self.rating =  Int("\(dict.value(forKey: "rating") ?? "" )" ) ?? 0
// = self.rating =  Int("\(dict.value(forKey: "rating") as? String ?? "" )" ) ?? 0

        self.message = dict.value(forKey: "message") as? String ?? ""
    }
    
    static func == (lhs: OrderItemModel, rhs: OrderItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
