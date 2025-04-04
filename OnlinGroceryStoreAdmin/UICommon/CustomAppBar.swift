//
//  AppBar.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 30/01/2025.
//

import SwiftUI

struct CustomAppBar: View {
    var colorAppBar: Color? = .clear // AppBar background will be transparent
    
    var leftIcon: String? = nil
    var leftAction: (() -> Void)? = nil
    var leftIconSize: CGFloat = 24
    var leftIconColor: Color = .blue
    
    var rightIcon: String? = nil
    var rightAction: (() -> Void)? = nil
    var rightIconSize: CGFloat = 24
    var rightIconColor: Color = .blue
    
    var title: String? = ""
    var textAlignment: TextAlignment = .center
    var font: Font = .headline
    var titleColor: Color = .black
    
    var body: some View {
        ZStack(alignment: .top) {
               HStack {
                // Left icon or button
                if let leftIcon = leftIcon {
                    Button(action: {
                        leftAction?()
                    }) {
                        Image(leftIcon)
                            .resizable()
                        //  .enderingMode(.template) // Allows icon color modification via foregroundColor
                            .scaledToFit()
                            .frame(width: leftIconSize, height: leftIconSize)
                            .foregroundColor(leftIconColor)
                    }
                    .padding(.leading, 16)
                } else {
                    Spacer().frame(width: leftIconSize)
                }
                
                Spacer()
                
                // Title text with dynamic alignment
                switch textAlignment {
                case .leading:
                    Text(title ?? "")
                        .font(font)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                case .center:
                    Text(title ?? "")
                        .font(font)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    
                case .trailing:
                    Text(title ?? "")
                        .font(font)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                }
                
                Spacer()
                
                // Right icon or button
                if let rightIcon = rightIcon {
                    Button(action: {
                        rightAction?()
                    }) {
                        Image(rightIcon)
                            .resizable()
                        //          .renderingMode(.template) // Allows icon color modification via foregroundColor
                            .scaledToFit()
                            .frame(width: rightIconSize, height: rightIconSize)
                            .foregroundColor(rightIconColor)
                    }
                    .padding(.trailing, 16)
                } else {
                    Spacer().frame(width: rightIconSize)
                }
        }
//               .frame(height: .topInsets)
            .padding(.top, .topInsets) // Adjust based on safe area
            .foregroundColor(titleColor)
            .background(colorAppBar)
            
        }
        .ignoresSafeArea(edges: .top) // Ensure it extends to the top edge
    }
}



