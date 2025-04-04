//
//  Globs.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 16/01/2025.
//

import SwiftUI

struct Globs {
    static let appName = "Online Groceries"
    
    struct UDKeys {
        /// Key for storing user payload in UserDefaults.
        static let userPayload = "user_payload"
        /// Key for storing user login status in UserDefaults.
        static let userLogin = "user_login"
    }
    struct Endpoints {
        static let baseURL = "http://localhost:3001/api/admin/"

        // MARK: - Authentication
        static let login = baseURL + "login"
        
        static let brandAdd = baseURL + "brand_add"
        static let brandUpdate = baseURL + "brand_update"
        static let brandList = baseURL + "brand_list"
        static let brandDelete = baseURL + "brand_delete"
        
        static let zoneAdd = baseURL + "zone_add"
        static let zoneUpdate = baseURL + "zone_update"
        static let zoneList = baseURL + "zone_list"
        static let zoneDelete = baseURL + "zone_delete"
        
        static let areaAdd = baseURL + "area_add"
        static let areaUpdate = baseURL + "area_update"
        static let areaList = baseURL + "area_list"
        static let areaDelete = baseURL + "area_delete"
        
        static let categoryAdd = baseURL + "product_category_add"
        static let categoryUpdate = baseURL + "product_category_update"
        static let categoryDelete = baseURL + "product_category_delete"
        static let categoryList = baseURL + "product_category_list"
        
        static let SV_TYPE_ADD = baseURL + "product_type_add"
        static let SV_TYPE_UPDATE = baseURL + "product_type_update"
        static let SV_TYPE_DELETE = baseURL + "product_type_delete"
        static let SV_TYPE_LIST = baseURL + "product_type_list"
        
        static let SV_PROMO_CODE_ADD = baseURL + "promo_code_add"
        static let SV_PROMO_CODE_UPDATE = baseURL + "promo_code_update"
        static let SV_PROMO_CODE_DELETE = baseURL + "promo_code_delete"
        static let SV_PROMO_CODE_LIST = baseURL + "promo_code_list"
        
        
        static let SV_PRODUCT_ADD = baseURL + "product_add"
        static let SV_PRODUCT_UPDATE = baseURL + "product_update"
        static let SV_PRODUCT_DELETE = baseURL + "product_delete"
        static let SV_PRODUCT_LIST = baseURL + "product_list"
        static let SV_PRODUCT_DETAIL = baseURL + "product_detail"

        static let SV_PRODUCT_NUTRITION_ADD = baseURL + "product_nutrition_add"
        static let SV_PRODUCT_NUTRITION_DELETE = baseURL + "product_nutrition_delete"
        static let SV_PRODUCT_IMAGE_ADD = baseURL + "product_image_add"
        static let SV_PRODUCT_IMAGE_DELETE = baseURL + "product_image_delete"
        static let SV_PRODUCT_CATEGORY_TYPE_BRAND = baseURL + "product_category_type_brand_list"
        
        static let SV_OFFER_ADD = baseURL + "offer_add"
        static let SV_OFFER_DELETE = baseURL + "offer_delete"
        static let SV_OFFER_PRODUCT_LIST = baseURL + "offer_product_list"
        
        static let SV_NEW_ORDER_LIST = baseURL + "new_orders_list"
        static let SV_COMPLETED_ORDER_LIST = baseURL + "completed_orders_list"
        static let SV_CANCEL_ORDER_LIST = baseURL + "cancel_decline_orders_list"
        
        static let SV_ORDER_DETAIL = baseURL + "order_detail"
        static let SV_ORDER_STATUS_CHANGE = baseURL + "order_status_change"

    }
    
}

// MARK: - API Response Keys
struct ResponseKeys {
    static let status = "status"
    static let message = "message"
    static let payload = "payload"
}

// MARK: - User Defoault Manager
class UDManager {
    class func UDSET(_ data: Any, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    class func UDValue( key: String) -> Any {
       return UserDefaults.standard.value(forKey: key) as Any
    }
    
    class func UDValueBool( key: String) -> Bool {
       return UserDefaults.standard.value(forKey: key) as? Bool ?? false
    }
    
    class func UDValueTrueBool( key: String) -> Bool {
       return UserDefaults.standard.value(forKey: key) as? Bool ?? true
    }
    
    class func UDRemove( key: String) {
        UserDefaults.standard.removeObject(forKey: key)

    }
}



 
