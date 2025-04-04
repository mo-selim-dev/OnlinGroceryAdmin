//
//  MainTabView.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 23/01/2025.
//

import SwiftUI
import Combine

struct MainTabView: View {
    
    @ObservedObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack{
            
                
                if(homeVM.selectTab == 0){
                    HomeView()
                }else if(homeVM.selectTab == 1){
                    ExploreView()
                }else if(homeVM.selectTab == 2){
                    MyCartView()
                }else if(homeVM.selectTab == 3){
                    FavouriteView()
                }else if(homeVM.selectTab == 4){
                    AccountView()
                }
            
                
//                TabView(selection: $homeVM.selectTab) {
//                    HomeView().tag(0)
//                    ExploreView().tag(1)
//                    ExploreView().tag(2)
//                    ExploreView().tag(3)
//                    ExploreView().tag(4)
//                }
//    //                             .onAppear{
//    //                                 UIScrollView.appearance().isScrollEnabled = false
//    //                           }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//                .onChange(of: homeVM.selectTab) { newValue in
//                    debugPrint("Sel Tab: \(newValue)")
//                }
            
            VStack{
                
                Spacer()
                
                HStack {
                    TabButton(title: "Shop", icon: "store_tab", isSelect: homeVM.selectTab == 0) {
                        
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 0
                            }
                        }
                        
                    }
                    
                    TabButton(title: "Explore", icon: "explore_tab", isSelect: homeVM.selectTab == 1) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 1
                            }
                        }                    }
                    
                    TabButton(title: "Cart", icon: "cart_tab", isSelect: homeVM.selectTab == 2) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 2
                            }
                        }                    }
                    
                    TabButton(title: "Favourite", icon: "fav_tab", isSelect: homeVM.selectTab == 3) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 3
                            }
                        }
                    }
                    
                    TabButton(title: "Account", icon: "account_tab", isSelect: homeVM.selectTab == 4) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 4
                            }
                        }
                    }
                    
                    
                }
                .padding(.top, 10)
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .background(.white)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: -2)
                
            }
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
        
        
    }
}

#Preview {
    NavigationView{
        MainTabView()

    }
}
