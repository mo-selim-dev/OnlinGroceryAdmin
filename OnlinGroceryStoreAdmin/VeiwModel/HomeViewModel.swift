//
//  HomeViewModel.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 23/01/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject
{
    static var shared: HomeViewModel = HomeViewModel()
    
    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""
    
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var offerArr: [ProductModel] = []
    @Published var bestArr: [ProductModel] = []
    @Published var listArr: [ProductModel] = []
    @Published var typeArr: [CategoryModel] = []
    
    
    init() {
//        serviceCallList()
    }

    
    // MARK: - serviceCallList

//    func serviceCallList(){
//        ServiceCall.post(parameter: [:], path: Globs.Endpoints.home, isToken: true ) { responseObj in
//            if let response = responseObj as? NSDictionary {
//                if response.value(forKey: ResponseKeys.status) as? String ?? "" == "1" {
//                    
//                    if let payloadObj = response.value(forKey: ResponseKeys.payload) as? NSDictionary {
//                        self.offerArr = (payloadObj.value(forKey: "offer_list") as? NSArray ?? []).map({ obj in
//                            
//                            return ProductModel(dict: obj as? NSDictionary ?? [:])
//                        })
//                        
//                        self.bestArr = (payloadObj.value(forKey: "best_sell_list") as? NSArray ?? []).map({ obj in
//                            
//                            return ProductModel(dict: obj as? NSDictionary ?? [:])
//                        })
//                        
//                        self.listArr = (payloadObj.value(forKey: "list") as? NSArray ?? []).map({ obj in
//                            
//                            return ProductModel(dict: obj as? NSDictionary ?? [:])
//                        })
//                        
//                        self.typeArr = (payloadObj.value(forKey: "type_list") as? NSArray ?? []).map({ obj in
//                            
//                            return CategoryModel(dict: obj as? NSDictionary ?? [:])
//                        })
//                    }
//                    
//                    
//                }else{
//                    self.errorMessage = response.value(forKey: ResponseKeys.message) as? String ?? "Invalid response from server"
//                    self.showError = true
//                }
//            }
//        } failure: { error in
//            self.errorMessage = error?.localizedDescription ?? "Network request failed"
//            self.showError = true
//        }
//    }

    
}




