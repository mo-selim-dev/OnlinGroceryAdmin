//
//  OnlinGroceryStoreAdminApp.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 27/02/2025.
//

import SwiftUI

@main
struct OnlinGroceryStoreAdminApp: App {
    @StateObject var mainVM = MainViewModel.shared
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                if mainVM.isUserLogin {
                    MainTabView()
                }else{
                    WelcomeView()

                }
            }
            
            
        }
    }
}
