//
//  AreaViewModel.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 20/03/2025.
//

import SwiftUI

class AreaViewModel: ObservableObject {
    static let shared: AreaViewModel = AreaViewModel()
    
    @Published var listArr: [AreaModel] = [];
    @Published var zoneObj: ZoneModel?
    @Published var areaObj: AreaModel?
    
    @Published var txtName: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    // الدالة setZoneObj تُستخدم لتحديث قيمة zoneObj داخل الكلاس بناءً على الكائن الذي يتم تمريره إليها.
    func setZoneObj( zObj: ZoneModel) {
        self.zoneObj = zObj
    }
    
    //MARK: Actions
    func actionOpenAdd(){
        areaObj = nil
        isEdit = false
        txtName = ""
        showAddEdit = true
    }
    //--------------
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone area name"
            self.showError = true
            return
        }
        apiAdd() {
            didDone?()
        }
    }
    //--------------
    
    func actionEdit(obj: AreaModel) {
        areaObj = obj
        txtName = obj.areaName
        isEdit = true
        showAddEdit = true
    }
    //--------------
    
    func actionUpdate(didDone: ( ()->() )?){
        if(areaObj == nil) {
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
        apiUpdate(areaId: areaObj?.areaId ?? 0) {
            //            self.apiList() // إعادة تحميل القائمة بعد التعديل
            didDone?()
            //            self.showAddEdit = false // إغلاق نافذة التعديل
        }
    }
    //--------------
    
    func actionDelete(obj: AreaModel) {
        apiDelete(areaId: obj.areaId)
        //        apiList() // إعادة تحميل القائمة بعد الحذف
    }
    
    
    
    
    //MARK: - ApiCalling
    func apiList() {
        ServiceCall.post(parameter: ["zone_id": self.zoneObj?.zoneId ?? ""], path: Globs.Endpoints.areaList, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: ResponseKeys.status) as? String ?? "" == "1") {
                    
                    self.listArr = (responseObj.value(forKey: ResponseKeys.payload) as? [NSDictionary] ?? []).map({ obj in
                        return AreaModel(dict: obj)
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
    func apiAdd(didDone: ( ()->() )?){
        ServiceCall.post(parameter: ["zone_id": self.zoneObj?.zoneId ?? "","area_name": txtName ],path:Globs.Endpoints.areaAdd, isToken: true) { responseObj in
            
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
    func apiUpdate(areaId: Int, didDone: ( ()-> () )? ) {
        
        ServiceCall.post(parameter: ["area_id": areaId, "area_name": txtName, "zone_id": self.zoneObj?.zoneId ?? ""], path: Globs.Endpoints.areaUpdate, isToken: true) { responseObj in
            
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
    func apiDelete(areaId: Int) {
        ServiceCall.post(parameter: ["area_id": areaId], path: Globs.Endpoints.areaDelete, isToken: true) { responseObj in
            
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
