//
//  ZoneAddView.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 17/03/2025.
//

import SwiftUI

struct ZoneAddView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var zVM = ZoneViewModel.shared
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
                    
                    Text(zVM.isEdit ? "Edit Zone" : "Add New Zone")
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
                        FormTextfield(title: "Zone Name", placholder: "Enter Zone Name", txt: $zVM.txtName)
                        
                        RoundButton(title: zVM.isEdit ? "Update" : "Add") {
                            if(zVM.isEdit){
                                zVM.actionUpdate {
                                    dismiss()
                                }
                            }else{
                                zVM.actionAdd {
                                    dismiss()
                                }
                            }
                            
                            
                        }
                    }
                    .padding(20)

                }

            }
        }
        .alert(isPresented: $zVM.showError) {
            Alert(title: Text(Globs.appName), message: Text(zVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}


#Preview {
    ZoneAddView()
}
