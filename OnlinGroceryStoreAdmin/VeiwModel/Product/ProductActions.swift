//
//  ProductActions.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 22/05/2025.
//

import Foundation

extension ProductViewModel {
    //MARK: - Form Actions
    
    func actionOpenAdd() {
        prodObj = nil
        isEdit = false
        txtName = ""
        txtDetail = ""
        txtUnitName = ""
        txtUnitValue = ""
        txtNutritionWeight = ""
        txtNutritionName = ""
        txtNutritionValue = ""
        txtPrice = ""
        selectNutritionObj = nil
        
        selectCategory = nil
        selectBrand = nil
        selectType = nil
        
        nutritionArr = []
        imageArr = []
        image = nil
        showAdd = true
    }
    
    func actionEdit(obj: ProductModel) {
        prodObj = obj
        txtName = obj.name
        txtDetail = obj.detail
        txtUnitName = obj.unitName
        txtUnitValue = obj.unitValue
        txtNutritionWeight = obj.nutritionWeight
        txtNutritionName = ""
        txtNutritionValue = ""
        txtPrice = "\(obj.price)"
        
        selectCategory = categoryArr.first(where: { nObj in
            return nObj.value(forKey:"cat_id") as? Int ?? -1  == obj.catId
        })
        
        selectBrand = brandArr.first(where: { nObj in
            return nObj.value(forKey:"brand_id") as? Int ?? -1  == obj.brandId
        })
        
        selectType = typeArr.first(where: { nObj in
            return nObj.value(forKey:"type_id") as? Int ?? -1  == obj.typeId
        })
        
        image = nil
        showAdd = false
        isEdit = true
        
        actionApiCallingDetail()
    }
    
    func actionOpenDetail(obj: ProductModel) {
        self.productDetailObj = nil
        self.productNutritionArr = []
        self.productImageArr = []
        prodObj = obj
        actionApiCallingDetail()
    }
    
    func actionApiCallingDetail() {
        apiProductDetail(prodId: prodObj?.id ?? 0)
    }
    
    //MARK: - Nutrition Actions
    
    func actionNewNutritionAdd() {
        if (txtNutritionName.isEmpty) {
            self.errorMessage = "Please enter product nutrition name"
            self.showError = true
            return
        }
        
        if (txtNutritionValue.isEmpty) {
            self.errorMessage = "Please enter product nutrition value"
            self.showError = true
            return
        }
        
        nutritionArr.append(NutritionModel(dict: [
            "nutrition_name": txtNutritionName,
            "nutrition_value": txtNutritionValue
        ]))
        
        txtNutritionName = ""
        txtNutritionValue = ""
    }
    
    func actionNewNutritionDelete(obj: NutritionModel) {
        if let index = nutritionArr.firstIndex(of: obj) {
            nutritionArr.remove(at: index)
        }
    }
    
    func actionNutritionAdd() {
        if (txtNutritionName.isEmpty) {
            self.errorMessage = "Please enter product nutrition name"
            self.showError = true
            return
        }
        
        if (txtNutritionValue.isEmpty) {
            self.errorMessage = "Please enter product nutrition value"
            self.showError = true
            return
        }
        
        apiNutritionAdd(parameter: [
            "prod_id": productDetailObj?.id ?? "",
            "nutrition_name": txtNutritionName,
            "nutrition_value": txtNutritionValue
        ])
    }
    
    func actionNutritionDelete(obj: NutritionModel) {
        apiNutritionDelete(parameter: [
            "prod_id": productDetailObj?.id ?? "",
            "nutrition_id": obj.id
        ])
    }
    
    //MARK: - Image Actions
    
    func actionImageAdd() {
        if image == nil {
            self.errorMessage = "Please select product image"
            self.showError = true
            return
        }
        
        apiImageAdd()
    }
    
    func actionImageDelete(obj: ImageModel) {
        apiImageDelete(parameter: [
            "prod_id": productDetailObj?.id ?? "",
            "img_id": obj.id
        ])
    }
}
