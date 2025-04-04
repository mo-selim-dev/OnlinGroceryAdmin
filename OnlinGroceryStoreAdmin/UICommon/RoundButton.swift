//
//  RoundButton.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 12/01/2025.
//

import SwiftUI

struct RoundButton: View {
    @State var title: String = "Tittle"
    @State var color: Color = Color.primaryApp
    var didTap: (()->())?
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
        .background(color)
        .cornerRadius(20)
    }
}


#Preview {
    RoundButton()
        .padding(20)
}
