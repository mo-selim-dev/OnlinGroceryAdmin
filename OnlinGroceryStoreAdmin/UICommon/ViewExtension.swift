//
//  SwiftUIView.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 22/01/2025.
//

import SwiftUI

// MARK: - ViewExtension
/// This file contains shared SwiftUI components for authentication screens (e.g., LoginView, SignUpView).
/// These components are reusable and can be used across multiple views to ensure consistency.

// MARK: - Shared Subviews and Logic
extension View {
    // MARK: Background Image
    /// Returns a background image for authentication screens.
    func backgroundImage() -> some View {
        Image("bottom_bg")
            .resizable()
            .scaledToFill()
            .frame(width: .screenWidth, height: .screenHeight)
    }
    
//    // MARK: Back Button
//    /// Returns a back button for authentication screens.
//    /// - Parameters:
//    ///   - iconName: The name of the icon to be used for the back button. Default is "back".
//    ///   - iconSize: The size of the icon. Default is 25x25.
//    ///   - action: The `DismissAction` to handle the back button tap.
//    func backButton(
//        iconName: String = "back",
//        iconSize: CGSize = CGSize(width: 25, height: 25),
//        action: DismissAction
//    ) -> some View {
//        VStack {
//            HStack {
//                Button {
//                    action()
//                } label: {
//                    Image(iconName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: iconSize.width, height: iconSize.height)
//                }
//                Spacer()
//            }
//            Spacer()
//        }
//        .padding(.top, .topInsets)
//        .padding(.horizontal, 20)
//    }
//    
//    // MARK: Share Button
//    func shareButton(action: @escaping () -> Void) -> some View {
//        VStack {
//            HStack {
//                Spacer()
//                Button {
//                    action()
//                } label: {
//                    Image("share")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 25, height: 25)
//                }
//            }
//            Spacer()
//        }
//        .padding(.top, .topInsets)
//        .padding(.horizontal, 20)
//    }
    
    
    // MARK: Logo Image
    /// Returns a logo image for authentication screens.
    func logoImage() -> some View {
        Image("color_logo")
            .resizable()
            .scaledToFit()
            .frame(width: 40)
            .padding(.bottom, .screenWidth * 0.1)
    }
    
    // MARK: Title Section
    /// Returns a title and subtitle section for authentication screens.
    /// - Parameters:
    ///   - title: The title text.
    ///   - subtitle: The subtitle text.
    func titleSection(
        title: String,
        subtitle: String,
        titleFont: Font = .customfont(.semibold, fontSize: 26),
        subtitleFont: Font = .customfont(.semibold, fontSize: 16),
        titleColor: Color = .primaryText,
        subtitleColor: Color = .secondaryText,
        spacing: CGFloat = 4
    ) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(title)
                .font(titleFont)
                .foregroundColor(titleColor)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            
            Text(subtitle)
                .font(subtitleFont)
                .foregroundColor(subtitleColor)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, .screenWidth * 0.1)
        }
    }
    
    // MARK: Terms and Conditions Section
    /// Returns a terms and conditions section for authentication screens.
    /// - Parameters:
    ///   - termsText: The text for the terms of service link.
    ///   - privacyText: The text for the privacy policy link.
    ///   - termsColor: The color for the terms of service link.
    ///   - privacyColor: The color for the privacy policy link.
    func termsAndConditionsSection(
        termsText: String = "Terms of Service",
        privacyText: String = "Privacy Policy.",
        termsColor: Color = .primaryApp,
        privacyColor: Color = .primaryApp,
        fontSize: CGFloat = 14
    ) -> some View {
        VStack {
            Text("By continuing you agree to our")
                .font(.customfont(.medium, fontSize: fontSize))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(termsText)
                    .font(.customfont(.medium, fontSize: fontSize))
                    .foregroundColor(termsColor)
                
                Text(" and ")
                    .font(.customfont(.medium, fontSize: fontSize))
                    .foregroundColor(.secondaryText)
                
                Text(privacyText)
                    .font(.customfont(.medium, fontSize: fontSize))
                    .foregroundColor(privacyColor)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, .screenWidth * 0.02)
        }
    }
    
    
        /// Applies a corner radius to specific corners of the view.
        /// - Parameters:
        ///   - cornerRadius: The radius of the corners.
        ///   - corner: The corner to apply the radius.
    func cornerRadius(_ cornerRadius: CGFloat, corner: UIRectCorner ) -> some View {
            clipShape(RoundedCorner(radius: cornerRadius, corners: corner))
        }
    }
    
    /// A custom shape that applies a corner radius to specific corners.
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
 

