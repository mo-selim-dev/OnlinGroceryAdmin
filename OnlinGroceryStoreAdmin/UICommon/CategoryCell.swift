//
//  CategoryCell.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 24/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCell: View {
    @State var tObj: CategoryModel = CategoryModel(dict: [ : ])
    @State var color: Color = Color.yellow
    var didAddCart: ( ()->() )?
    
    var body: some View {
        HStack{
            
            WebImage(url: URL(string: tObj.image ))
                .resizable()
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 70, height: 70)
            
            
            
            Text(tObj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(15)
        .frame(width: 250, height: 100)
        .background( tObj.color.opacity(0.3) )
        .cornerRadius(16)
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(tObj: CategoryModel(dict: [ "type_id": 3,
                                                 "type_name": "Rice",
                                                 "image": "http://localhost:3001/img/type/202307311000160168a0737aEiC.png",
                                                 "color": "53B175"]))
    }
}

