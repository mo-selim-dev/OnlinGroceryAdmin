//
//  BrandAddView.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 03/03/2025.
//

import SwiftUI

struct BrandAddView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var bVM = BrandViewModel.shared
    var body: some View {
        ZStack{
            
         
            VStack{
                
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 40, height: 40)
                    
                    Text(bVM.isEdit ? "Edit Brand" : "Add New Brands")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    EmptyView()
                    .frame(width: 40, height: 40)
                    
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 8)
                .background(Color.white)
                .shadow(radius: 2)
                
                ScrollView{
                    VStack{
                        FormTextfield(title: "Brand Name", placholder: "Enter Brand Name", txt: $bVM.txtBrandName)
                        
                        RoundButton(title: bVM.isEdit ? "Update" : "Add") {
                            if(bVM.isEdit){
                                bVM.actionUpdate {
                                    dismiss()
                                }
                            }else{
                                bVM.actionAdd {
                                    dismiss()
                                }
                            }
                            
                            
                        }
                    }
                    .padding(20)

                }

            }
        }
        .alert(isPresented: $bVM.showError) {
            Alert(title: Text(Globs.appName), message: Text(bVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    BrandAddView()
}
