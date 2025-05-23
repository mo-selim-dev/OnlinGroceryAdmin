//
//  ProductValidations.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 22/05/2025.
//

import Foundation

extension ProductViewModel {
    //MARK: - Form Validations
    
    func validateAddForm() -> Bool {
        if txtName.isEmpty {
            showError(message: "Please enter product name")
            return false
        }
        
        if txtDetail.isEmpty {
            showError(message: "Please enter product detail")
            return false
        }
        
        if selectCategory == nil {
            showError(message: "Please select product category")
            return false
        }
        
        if selectBrand == nil {
            showError(message: "Please select product brand")
            return false
        }
        
        if selectType == nil {
            showError(message: "Please select product type")
            return false
        }
        
        if txtUnitName.isEmpty {
            showError(message: "Please enter product unit name")
            return false
        }
        
        if txtUnitValue.isEmpty {
            showError(message: "Please enter product unit value")
            return false
        }
        
        if txtNutritionWeight.isEmpty {
            showError(message: "Please enter nutrition weight")
            return false
        }
        
        if txtPrice.isEmpty {
            showError(message: "Please enter price")
            return false
        }
        
        if imageArr.isEmpty {
            showError(message: "Please select product image")
            return false
        }
        
        return true
    }
    
    private func showError(message: String) {
        self.errorMessage = message
        self.showError = true
    }
}
