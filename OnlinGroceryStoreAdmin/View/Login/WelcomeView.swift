//
//  WelcomeView.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 12/01/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        ZStack{
            Image("sign_in_top")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                    .overlay(alignment: .bottom) {
                        Circle()
                            .frame(width: 85, height: 85)
                            .foregroundColor(Color(hex: "31511E"))
                            .opacity(0.9)
                            .shadow(color: Color(hex: "31511E"), radius: 35, x: -20, y: 20)
                        
                        Image("app_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding(.bottom, 8)
                    }
                    .padding()
                
                Text("Welcome")
                    .font(.customfont(.semibold, fontSize: 48))
                    .foregroundColor(Color(hex: "31511E"))
                    .opacity(0.9)
                    .multilineTextAlignment(.center)
                
                Text("This is a simple application tested by me")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundStyle(Color(hex: "31511E").opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                NavigationLink {
                    SignInView()
                } label: {
                    RoundButton(title: "Get Started", color: Color(hex: "31511E").opacity(0.9)) {
                        
                    }

                }

                
                Spacer()
                    .frame(height: 60)
                
            }
            .padding(.horizontal, 20)
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    NavigationView {
        WelcomeView()
    }
}
