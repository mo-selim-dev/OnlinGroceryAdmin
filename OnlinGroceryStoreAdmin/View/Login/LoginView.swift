//
//  LoginView.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 14/01/2025.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background Image
            backgroundImage()
            
            // Back Button
//            backButton(action: dismiss)
            CustomAppBar(
                leftIcon: "back", leftAction: { dismiss() }
                          )
            // Main Content
            VStack(spacing: 20) {
                // Logo
                logoImage()
                
                // Title and Subtitle
                titleSection(title: "Login", subtitle: "Enter your email and password")
                
                // Email Field
                FormTextfield(
                    title: "Email",
                    placholder: "Enter your email address",
                    txt: $mainVM.txtEmail,
                    keyboardType: .emailAddress
                )
//                .padding(.bottom, 20)
                .padding(.bottom, .screenWidth * 0.07)

                
                // Password Field
                FormSecureField(
                    title: "Password",
                    placholder: "Enter your password",
                    txt: $mainVM.txtPassword,
                    isShowPassword: $mainVM.isShowPassword
                )
//                .padding(.bottom, 10)
                .padding(.bottom, .screenWidth * 0.02)

                
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.primaryText)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, .screenWidth * 0.03)
                
                // Login Button
                RoundButton(title: "Log In") {
                    mainVM.serviceCallLogin()
                }
//                .padding(.bottom, 20)
                .padding(.bottom, .screenWidth * 0.05)

                
                // Signup Navigation
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack {
                        Text("Don’t have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        Text("Signup")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryApp)
                    }
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            

        }
        .alert(isPresented: $mainVM.showError) {
            Alert(
                title: Text(Globs.appName),
                message: Text(mainVM.errorMessage),
                dismissButton: .default(Text("Ok"))
            )
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}


#Preview {
    NavigationView{
        LoginView()
    }
}
