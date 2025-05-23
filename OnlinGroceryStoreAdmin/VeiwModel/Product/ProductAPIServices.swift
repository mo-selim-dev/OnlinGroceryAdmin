//
//  ProductAPIServices.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 22/05/2025.
//

import Foundation
import UIKit


extension ProductViewModel {
    //MARK: - API Services
    
    func apiList() {
        ServiceCall.post(parameter: [:], path: Globs.Endpoints.SV_PRODUCT_LIST, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.listArr = (responseObj.value(forKey: ResponseKeys.payload) as? [NSDictionary] ?? []).map { obj in
                        return ProductModel(dict: obj)
                    }
                } else {
                    self.listArr = []
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiAdd(didDone: ( ()->() )?) {
        var imgObj: [UIImage: String] = [:]
        imageArr.forEach { img in
            imgObj[img] = "image"
        }
        
        ServiceCall.multipart(parameter: [
            "name": txtName,
            "detail": txtDetail,
            "cat_id": selectCategory?.value(forKey: "cat_id") ?? "",
            "brand_id": selectBrand?.value(forKey: "brand_id") ?? "",
            "type_id": selectType?.value(forKey: "type_id") ?? "",
            "unit_name": txtUnitName,
            "unit_value": txtUnitValue,
            "nutrition_weight": txtNutritionWeight,
            "price": txtPrice,
            "nutrition_data": UDManager.jsonString(obj: nutritionArr.map { nObj in
                return [
                    "nutrition_name": nObj.nutritionName,
                    "nutrition_value": nObj.nutritionValue
                ]
            }, prettyPrint: false)
        ], path: Globs.Endpoints.SV_PRODUCT_ADD, imageDic: imgObj as NSDictionary, isToken: true, isUIImageKey: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
                    self.apiList()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiUpdate(prodId: Int, didDone: ( ()->() )?) {
        ServiceCall.post(parameter: [
            "prod_id": prodId,
            "name": txtName,
            "detail": txtDetail,
            "cat_id": selectCategory?.value(forKey: "cat_id") ?? "",
            "brand_id": selectBrand?.value(forKey: "brand_id") ?? "",
            "type_id": selectType?.value(forKey: "type_id") ?? "",
            "unit_name": txtUnitName,
            "unit_value": txtUnitValue,
            "nutrition_weight": txtNutritionWeight,
            "price": txtPrice
        ], path: Globs.Endpoints.SV_PRODUCT_UPDATE, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
                    self.apiList()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiDelete(prodId: Int) {
        ServiceCall.post(parameter: ["prod_id": prodId], path: Globs.Endpoints.SV_PRODUCT_DELETE, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    self.apiList()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiCategoryTypeBrandList() {
        ServiceCall.post(parameter: [:], path: Globs.Endpoints.SV_PRODUCT_CATEGORY_TYPE_BRAND, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    let payload = responseObj.value(forKey: ResponseKeys.payload) as? NSDictionary ?? [:]
                    self.categoryArr = payload.value(forKey: "category_list") as? [NSDictionary] ?? []
                    self.brandArr = payload.value(forKey: "brand_list") as? [NSDictionary] ?? []
                    self.typeArr = payload.value(forKey: "type_list") as? [NSDictionary] ?? []
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiProductDetail(prodId: Int) {
        ServiceCall.post(parameter: ["prod_id": prodId], path: Globs.Endpoints.SV_PRODUCT_DETAIL, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    let payload = responseObj.value(forKey: ResponseKeys.payload) as? NSDictionary ?? [:]
                    self.productDetailObj = ProductModel(dict: payload)
                    self.productNutritionArr = (payload.value(forKey: "nutrition_list") as? [NSDictionary] ?? []).map { obj in
                        return NutritionModel(dict: obj)
                    }
                    self.productImageArr = (payload.value(forKey: "images") as? [NSDictionary] ?? []).map { obj in
                        return ImageModel(dict: obj)
                    }
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiImageAdd() {
        ServiceCall.multipart(parameter: [
            "prod_id": prodObj?.id ?? "",
        ], path: Globs.Endpoints.SV_PRODUCT_IMAGE_ADD, imageDic: ["image": image!], isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    self.actionApiCallingDetail()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiImageDelete(parameter: NSDictionary) {
        ServiceCall.post(parameter: parameter, path: Globs.Endpoints.SV_PRODUCT_IMAGE_DELETE, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    self.actionApiCallingDetail()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiNutritionAdd(parameter: NSDictionary) {
        ServiceCall.post(parameter: parameter, path: Globs.Endpoints.SV_PRODUCT_NUTRITION_ADD, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.txtNutritionName = ""
                    self.txtNutritionValue = ""
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    self.actionApiCallingDetail()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
    
    func apiNutritionDelete(parameter: NSDictionary) {
        ServiceCall.post(parameter: parameter, path: Globs.Endpoints.SV_PRODUCT_NUTRITION_DELETE, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    self.actionApiCallingDetail()
                } else {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
    }
}
