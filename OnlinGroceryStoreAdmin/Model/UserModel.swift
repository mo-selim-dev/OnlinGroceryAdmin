//
//  UserModel.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 19/01/2025.
//


import SwiftUI

struct UserModel: Identifiable, Equatable {
    
    var id: Int = 0
    var username: String = ""
    var name: String = ""
    var email: String = ""
    var mobile: String = ""
    var mobileCode: String = ""
    var authToken: String = ""
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "user_id") as? Int ?? 0
        self.username = dict.value(forKey: "username") as? String ?? ""
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.email = dict.value(forKey: "email") as? String ?? ""
        self.mobile = dict.value(forKey: "mobile") as? String ?? ""
        self.mobileCode = dict.value(forKey: "mobile_code") as? String ?? ""
        self.authToken = dict.value(forKey: "auth_token") as? String ?? ""
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: Using [String: Any]
//import SwiftUI
//import Foundation
//
//// MARK: - UserModel
//struct UserModel: Identifiable, Equatable, Codable {
//    var id: Int
//    var username: String
//    var name: String
//    var email: String
//    var mobile: String
//    var mobileCode: String
//    var authToken: String
//
//    init(dict: [String: Any]) {
//        self.id = dict["user_id"] as? Int ?? 0
//        self.username = dict["username"] as? String ?? ""
//        self.name = dict["name"] as? String ?? ""
//        self.email = dict["email"] as? String ?? ""
//        self.mobile = dict["mobile"] as? String ?? ""
//        self.mobileCode = dict["mobile_code"] as? String ?? ""
//        self.authToken = dict["auth_token"] as? String ?? ""
//    }
//
//    // Equatable conformance
//    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//}



// MARK: Using Codable
//import SwiftUI
//import Foundation
//
//// MARK: - UserModel
//struct UserModel: Identifiable, Equatable, Codable {
//    var id: Int
//    var username: String
//    var name: String
//    var email: String
//    var mobile: String
//    var mobileCode: String
//    var authToken: String
//
//    // MARK: - CodingKeys
//    enum CodingKeys: String, CodingKey {
//        case id = "user_id"
//        case username
//        case name
//        case email
//        case mobile
//        case mobileCode = "mobile_code"
//        case authToken = "auth_token"
//    }
//
//    // MARK: - Equatable Conformance
//    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
