//
//  MainViewModel.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 15/01/2025.

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])
    
    init() {
        
        
        if( UDManager.UDValueBool(key: Globs.UDKeys.userLogin) ) {
            // User Login
            self.setUserData(uDict: UDManager.UDValue(key: Globs.UDKeys.userPayload) as? NSDictionary ?? [:] )
        }else{
            // User Not Login
        }
        
#if DEBUG
        txtUsername = "admin"
        txtEmail = "admin@admin.com"
        txtPassword = "123456"
#endif
        
    }
    
    func logout(){
        UDManager.UDSET(false, key: Globs.UDKeys.userLogin)
        isUserLogin = false
    }
    
    // MARK: - LoginView
    func serviceCallLogin(){
        
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        // Make the network request
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtPassword, "dervice_token":"" ], path: Globs.Endpoints.login) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: ResponseKeys.status) as? String ?? "" == "1" {
                    
                    
                    
                    self.setUserData(uDict: response.value(forKey: ResponseKeys.payload) as? NSDictionary ?? [:])
                    
                    
                }else{
                    self.errorMessage = response.value(forKey: ResponseKeys.message) as? String ?? "Invalid response from server"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Network request failed"
            self.showError = true
        }
        
    }
    
//    // MARK: - SignUpView
//    func serviceCallSignUp(){
//        
//        if(txtUsername.isEmpty) {
//            self.errorMessage = "please enter valid username"
//            self.showError = true
//            return
//        }
//        
//        
//        if(!txtEmail.isValidEmail) {
//            self.errorMessage = "please enter valid email address"
//            self.showError = true
//            return
//        }
//        
//        if(txtPassword.isEmpty) {
//            self.errorMessage = "please enter valid password"
//            self.showError = true
//            return
//        }
//        
//        ServiceCall.post(parameter: [ "username": txtUsername , "email": txtEmail, "password": txtPassword, "dervice_token":"" ], path: Globs.Endpoints.signUp) { responseObj in
//            if let response = responseObj as? NSDictionary {
//                if response.value(forKey: ResponseKeys.status) as? String ?? "" == "1" {
//                    self.setUserData(uDict: response.value(forKey: ResponseKeys.payload) as? NSDictionary ?? [:])
//                }else{
//                    self.errorMessage = response.value(forKey: ResponseKeys.message) as? String ?? "Invalid response from server"
//                    self.showError = true
//                }
//            }
//        } failure: { error in
//            self.errorMessage = error?.localizedDescription ?? "Network request failed"
//            self.showError = true
//        }
//        
//    }
//    
    // MARK: - Helper Methods
    func setUserData(uDict: NSDictionary) {
        
        UDManager.UDSET(uDict, key: Globs.UDKeys.userPayload)
        UDManager.UDSET(true, key: Globs.UDKeys.userLogin)
        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        
        self.txtUsername = ""
        self.txtEmail = ""
        self.txtPassword = ""
        self.isShowPassword = false
    }
//    
} //  End MainViewModel






