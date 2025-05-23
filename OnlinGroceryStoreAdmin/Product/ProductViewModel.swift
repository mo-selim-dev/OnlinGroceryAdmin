//
//  ProductViewModel.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 22/05/2025.
//


import SwiftUI

class ProductViewModel: ObservableObject {
    static let shared: ProductViewModel = ProductViewModel()
    
    // Published Properties
    @Published var listArr: [ProductModel] = []
    @Published var prodObj: ProductModel?
    
    // Form Fields
    @Published var txtName = ""
    @Published var txtDetail = ""
    @Published var txtUnitName = ""
    @Published var txtUnitValue = ""
    @Published var txtNutritionWeight = ""
    @Published var txtPrice = ""
    
    // Selection Fields
    @Published var selectCategory: NSDictionary?
    @Published var selectBrand: NSDictionary?
    @Published var selectType: NSDictionary?
    
    // Nutrition & Images
    @Published var nutritionArr: [NutritionModel] = []
    @Published var imageArr: [UIImage] = []
    
    // Product Detail
    @Published var productDetailObj: ProductModel?
    @Published var productNutritionArr: [NutritionModel] = []
    @Published var productImageArr: [ImageModel] = []
    
    // Lists
    @Published var categoryArr: [NSDictionary] = []
    @Published var brandArr: [NSDictionary] = []
    @Published var typeArr: [NSDictionary] = []
    
    // Image Picker
    @Published var image: UIImage?
    
    // Nutrition Editing
    @Published var selectNutritionObj: NutritionModel?
    @Published var txtNutritionName = ""
    @Published var txtNutritionValue = ""
    
    // Alerts & Errors
    @Published var showError = false
    @Published var errorMessage = ""
    
    // UI States
    @Published var isEdit = false
    @Published var showAdd = false
    @Published var showOfferAdd = false
    @Published var selectOfferProduct: ProductModel?
    @Published var showArea = false
    
    init() {
        apiCategoryTypeBrandList()
    }
}