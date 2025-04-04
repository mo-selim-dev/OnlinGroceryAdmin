//
//  BrandViewModel.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 02/03/2025.
//

import SwiftUI

class BrandViewModel: ObservableObject {
    static let shared: BrandViewModel = BrandViewModel()
    
    @Published var listArr: [BrandModel] = [];
    @Published var brandObj: BrandModel?
    
    @Published var txtBrandName: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    init() {
        
    }
    
    //MARK: Actions
    func actionOpenAdd(){
        brandObj = nil
        isEdit = false
        txtBrandName = ""
        showAddEdit = true
    }
    //--------------

    func actionAdd(didDone: ( ()->() )? ){
        if(txtBrandName.isEmpty) {
            self.errorMessage = "Please enter brand name"
            self.showError = true
            return
        }
        apiAdd() {
            didDone?()
        }
    }
    //--------------

    func actionEdit(obj: BrandModel) {
        brandObj = obj
        txtBrandName = obj.brandName
        isEdit = true
        showAddEdit = true
    }
    //--------------
    
    func actionUpdate(didDone: ( ()->() )?){
        if(brandObj == nil) {
            self.errorMessage = "No brand selected to update"  // إظهار رسالة خطأ إذا كان brandObj فارغًا
            self.showError = true
            return
        }
//        guard let brandObj = brandObj else {
//            self.errorMessage = "No brand selected to update"  // إظهار رسالة خطأ إذا كان brandObj فارغًا
//            self.showError = true
//            return
//        }
        if(txtBrandName.isEmpty) {
            self.errorMessage = "Please enter brand name"
            self.showError = true
            return
        }
        apiUpdate(brandId: brandObj?.brandId ?? 0) {
//            self.apiList() // إعادة تحميل القائمة بعد التعديل
            didDone?()
//            self.showAddEdit = false // إغلاق نافذة التعديل
        }
    }
    //--------------

    func actionDelete(obj: BrandModel) {
        apiDelete(brandId: obj.brandId)
//        apiList() // إعادة تحميل القائمة بعد الحذف
    }
    
    
    
    
    //MARK: - ApiCalling
    func apiList() {
        ServiceCall.post(parameter: [:], path: Globs.Endpoints.brandList, isToken: true) { responseObj in
                
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    
                    self.listArr = (responseObj.value(forKey: ResponseKeys.payload) as? [NSDictionary] ?? []).map({ obj in
                        return BrandModel(dict: obj)
                    })
                    
                }else{
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
    
    //MARK: - ApiAdd
    func apiAdd(didDone: (()-> ())?) {
        ServiceCall.post(parameter: ["brand_name": txtBrandName], path: Globs.Endpoints.brandAdd, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
                                        
                }else{
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                    
                }
            }
            
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
        
    }
    
    //brandObj?.brandId ?? ""
    //MARK: - ApiUpdate
    func apiUpdate(brandId: Int, didDone: ( ()-> () )? ) {
        
        ServiceCall.post(parameter: ["brand_id": brandId, "brand_name": txtBrandName], path: Globs.Endpoints.brandUpdate, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1"){

                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    didDone?()  // apiListBrand
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                    
                }
            }
            
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
        
    }
    
    
    //MARK: - ApiDelete
    func apiDelete(brandId: Int) {
        ServiceCall.post(parameter: ["brand_id": brandId], path: Globs.Endpoints.brandDelete, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "success"
                    self.showError = true
                    
                    self.apiList()
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: ResponseKeys.message) as? String ?? "fail"
                    self.showError = true
                    
                }
            }
            
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }
        
    }
    
    
    /*
     import SwiftUI

     class BrandViewModel: ObservableObject {
         static let shared: BrandViewModel = BrandViewModel()
         
         @Published var brands: [BrandModel] = []
         @Published var selectedBrand: BrandModel?
         
         @Published var brandName: String = ""
         
         @Published var showError: Bool = false
         @Published var errorMessage: String = ""
         
         @Published var isEditing = false
         @Published var showAddEdit = false
         
         init() {
             fetchBrands()
         }
         
         // MARK: - Actions
         func addBrand() {
             guard !brandName.isEmpty else {
                 showError(with: "Please enter brand name")
                 return
             }
             Task {
                 await apiAddBrand()
             }
         }
         
         func editBrand(brand: BrandModel) {
             selectedBrand = brand
             brandName = brand.brandName
             isEditing = true
             showAddEdit = true
         }
         
         func updateBrand() {
             guard let brand = selectedBrand else { return }
             
             guard !brandName.isEmpty else {
                 showError(with: "Please enter brand name")
                 return
             }
             
             Task {
                 await apiUpdateBrand(brandId: brand.brandId)
             }
         }
         
         func deleteBrand(brand: BrandModel) {
             Task {
                 await apiDeleteBrand(brandId: brand.brandId)
             }
         }
         
         // MARK: - Error Handling
         func showError(with message: String) {
             self.errorMessage = message
             self.showError = true
         }
         
         // MARK: - API Calls
         func fetchBrands() {
             Task {
                 await apiFetchBrands()
             }
         }
         
         func handleAPIResponse(response: NSDictionary) -> Bool {
             if (response.value(forKey: ResponseKeys.payload) as? String ?? "" == "1") {
                 self.brands = (response.value(forKey: ResponseKeys.payload) as? [NSDictionary] ?? []).map({ obj in
                     return BrandModel(dict: obj)
                 })
                 return true
             } else {
                 self.showError(with: response.value(forKey: ResponseKeys.message) as? String ?? "Failed")
                 return false
             }
         }

         func apiFetchBrands() async {
             do {
                 let response = try await ServiceCall.post(parameter: [:], path: Globs.Endpoints.brandList, isToken: true)
                 if let responseDict = response as? NSDictionary {
                     _ = handleAPIResponse(response: responseDict)
                 }
             } catch {
                 showError(with: error.localizedDescription)
             }
         }
         
         func apiAddBrand() async {
             do {
                 let response = try await ServiceCall.post(parameter: ["brand_name": brandName], path: Globs.Endpoints.brandAdd, isToken: true)
                 if let responseDict = response as? NSDictionary {
                     if handleAPIResponse(response: responseDict) {
                         showError(with: "Brand added successfully!")
                         await apiFetchBrands()  // Refresh the list
                     }
                 }
             } catch {
                 showError(with: error.localizedDescription)
             }
         }
         
         func apiUpdateBrand(brandId: Int) async {
             do {
                 let response = try await ServiceCall.post(parameter: ["brand_id": brandId, "brand_name": brandName], path: Globs.Endpoints.brandUpdate, isToken: true)
                 if let responseDict = response as? NSDictionary {
                     if handleAPIResponse(response: responseDict) {
                         await apiFetchBrands()
                     }
                 }
             } catch {
                 showError(with: error.localizedDescription)
             }
         }
         
         func apiDeleteBrand(brandId: Int) async {
             do {
                 let response = try await ServiceCall.post(parameter: ["brand_id": brandId], path: Globs.Endpoints.brandDelete, isToken: true)
                 if let responseDict = response as? NSDictionary {
                     if handleAPIResponse(response: responseDict) {
                         await apiFetchBrands()  // Refresh the list
                     }
                 }
             } catch {
                 showError(with: error.localizedDescription)
             }
         }
     }
     */
    
    
    
    
}


