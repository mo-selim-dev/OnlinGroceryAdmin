//
//  TabButton.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 23/01/2025.
//

import SwiftUI

struct TabButton: View {
    
    @State var title: String = "Title"
    @State var icon: String = "store_tab"
    var isSelect: Bool = false
    var didSelect: (()->())
    
    var body: some View {
        Button{
            didSelect()
        } label: {
            VStack{
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(title)
                    .font(.customfont(.semibold, fontSize: 14))
            }
            
            
            
        }
        //            .foregroundStyle(homVM.selectTab == 0 ? Color.primaryApp : .primaryText)
        .foregroundStyle(isSelect ? Color.primaryApp : .primaryText)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#Preview {
    TabButton{
        print("test")
    }
}
