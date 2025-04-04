//
//  zoneViewModel.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 17/03/2025.
//

import SwiftUI

class ZoneViewModel: ObservableObject {
    static let shared: ZoneViewModel = ZoneViewModel()
    
    @Published var listArr: [ZoneModel] = [];
    @Published var zoneObj: ZoneModel?
    
    @Published var txtName: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    @Published var showArea = false

    
    init() {
        
    }
    
    //MARK: Actions
    func actionOpenAdd(){
        zoneObj = nil
        isEdit = false
        txtName = ""
        showAddEdit = true
    }
    //--------------
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone name"
            self.showError = true
            return
        }
        apiAdd() {
            didDone?()
        }
    }
    //--------------
    
    func actionEdit(obj: ZoneModel) {
        zoneObj = obj
        txtName = obj.zoneName
        isEdit = true
        showAddEdit = true
    }
    //--------------
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if(zoneObj == nil) {
            self.errorMessage = "No brand selected to update"  // إظهار رسالة خطأ إذا كان brandObj فارغًا
            self.showError = true
            return
        }
        //        guard let brandObj = brandObj else {
        //            self.errorMessage = "No brand selected to update"  // إظهار رسالة خطأ إذا كان brandObj فارغًا
        //            self.showError = true
        //            return
        //        }
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone name"
            self.showError = true
            return
        }
        apiUpdate(zoneId: zoneObj?.zoneId ?? 0) {
            //            self.apiList() // إعادة تحميل القائمة بعد التعديل
            didDone?()
            //            self.showAddEdit = false // إغلاق نافذة التعديل
        }
    }
    //--------------
    
    func actionDelete(obj: ZoneModel) {
        apiDelete(zoneId: obj.zoneId)
        //        apiList() // إعادة تحميل القائمة بعد الحذف
    }
    
    
    
    
    //MARK: - ApiCalling
    func apiList() {
        ServiceCall.post(parameter: [:], path: Globs.Endpoints.zoneList, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    
                    self.listArr = (responseObj.value(forKey: ResponseKeys.payload) as? [NSDictionary] ?? []).map({ obj in
                        return ZoneModel(dict: obj)
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
        ServiceCall.post(parameter: ["zone_name": txtName], path: Globs.Endpoints.zoneAdd, isToken: true) { responseObj in
            
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
    func apiUpdate(zoneId: Int, didDone: ( ()-> () )? ) {
        
        ServiceCall.post(parameter: ["zone_id": zoneId, "zone_name": txtName], path: Globs.Endpoints.zoneUpdate, isToken: true) { responseObj in
            
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
    func apiDelete(zoneId: Int) {
        ServiceCall.post(parameter: ["zone_id": zoneId], path: Globs.Endpoints.zoneDelete, isToken: true) { responseObj in
            
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
    
}
