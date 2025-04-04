//
//  BrandView.swift
//  OnlinGroceryStoreAdmin
//
//  Created by Mohamed Selim on 02/03/2025.
//
//


//import SwiftUI
//
//// BrandView الأساسي
//struct BrandView: View {
//    @Environment(\.dismiss) var dismiss
//    @StateObject var bVM = BrandViewModel.shared
//    var body: some View {
//        ZStack {
//            
//            if bVM.listArr.isEmpty {
//                Text("Brand is Empty")
//                    .font(.customfont(.bold, fontSize: 20))
//            } else {
//                BrandListView(bVM: bVM)
//            }
//            
//            VStack {
//                HeaderView(dismiss: dismiss, onAdd: {
//                    bVM.actionOpenAdd()
//                })
//                Spacer()
//            }
//        }
//        .onAppear {
//            bVM.apiList()
//        }
//        .background(NavigationLink(destination: BrandAddView(), isActive: $bVM.showAddEdit) {
//            EmptyView()
//        })
//        .alert(isPresented: $bVM.showError) {
//            Alert(title: Text(Globs.appName), message: Text(bVM.errorMessage), dismissButton: .default(Text("OK")))
//        }
//        .background(Color.white)
//        .navigationTitle("")
//        .navigationBarBackButtonHidden()
//        .navigationBarHidden(true)
//        .ignoresSafeArea()
//    }
//}
//
//// HeaderView
//struct HeaderView: View {
//    @State var dismiss: DismissAction
//    var onAdd: () -> Void
//    
//    var body: some View {
//        HStack {
//            Button(action: {
//                dismiss()
//            }, label: {
//                Image("back")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//            })
//            .frame(width: 40, height: 40)
//            
//            Text("Brands")
//                .font(.customfont(.bold, fontSize: 20))
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            Button(action: {
//                onAdd()
//            }, label: {
//                Image("add_green")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//            })
//            .frame(width: 40, height: 40)
//        }
//        .padding(.top, .topInsets)
//        .padding(.horizontal, 8)
//        .background(Color.white)
//        .shadow(radius: 2)
//    }
//}
//
//// BrandListView
//struct BrandListView: View {
//    @ObservedObject var bVM: BrandViewModel
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 8) {
//                ForEach(bVM.listArr, id: \.id) { bObj in
//                    BrandItemView(bObj: bObj, onEdit: {
//                        bVM.actionEdit(obj: bObj)
//                    }, onDelete: {
//                        bVM.actionDelete(obj: bObj)
//                    })
//                }
//            }
//            .padding(20)
//            .padding(.top, .topInsets + 46)
//            .padding(.bottom, .bottomInsets)
//        }
//    }
//}
//
//// BrandItemView
//struct BrandItemView: View {
//    var bObj: BrandModel
//    var onEdit: () -> Void
//    var onDelete: () -> Void
//    
//    var body: some View {
//        HStack {
//            Text(bObj.brandName)
//                .font(.customfont(.medium, fontSize: 17))
//                .frame(maxWidth: .infinity, alignment: .leading)
//            
//            Button(action: {
//                onEdit()
//            }, label: {
//                Image(systemName: "pencil.line")
//                    .foregroundColor(.primaryApp)
//            })
//            
//            Button(action: {
//                onDelete()
//            }, label: {
//                Image(systemName: "trash.fill")
//                    .foregroundColor(.red)
//            })
//        }
//        .frame(height: 50)
//        .padding(.horizontal, 15)
//        .background(Color.white)
//        .cornerRadius(5)
//        .shadow(radius: 2)
//    }
//}
//
//// Preview
//#Preview {
//    BrandView()
//}



import SwiftUI

// مكون الـ HeaderView
struct BrandHeaderView: View {
    var dismiss: () -> Void
    var onAdd: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Image("back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            })
            .frame(width: 40, height: 40)
            
            Text("Brands")
                .font(.customfont(.bold, fontSize: 20))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: {
                onAdd()
            }, label: {
                Image("add_green")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            })
            .frame(width: 40, height: 40)
        }
        .padding(.top, .topInsets)
        .padding(.horizontal, 8)
        .background(Color.white)
        .shadow(radius: 2)
    }
}

// مكون الـ BrandListView
struct BrandListView: View {
    @ObservedObject var bVM: BrandViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(bVM.listArr, id: \.id) { bObj in
                    HStack {
                        Text(bObj.brandName)
                            .font(.customfont(.medium, fontSize: 17))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            bVM.actionEdit(obj: bObj)
                        }, label: {
                            Image(systemName: "pencil.line")
                                .foregroundColor(.primaryApp)
                        })
                        Button(action: {
                            bVM.actionDelete(obj: bObj)
                        }, label: {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                        })
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                }
            }
            .padding(20)
            .padding(.top, .topInsets + 46)
            .padding(.bottom, .bottomInsets)
        }
    }
}

// مكون BrandView الأساسي
struct BrandView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var bVM = BrandViewModel.shared
    
    var body: some View {
        ZStack {
            if bVM.listArr.isEmpty {
                Text("Brand is Empty")
                    .font(.customfont(.bold, fontSize: 20))
            }
            
            BrandListView(bVM: bVM)
            
            VStack {
                BrandHeaderView(dismiss: {
                    dismiss()
                }, onAdd: {
                    bVM.actionOpenAdd()
                })
                Spacer()
            }
        }
        .onAppear {
            bVM.apiList()
        }
        .background(NavigationLink(destination: BrandAddView(), isActive: $bVM.showAddEdit, label: {
            EmptyView()
        }))
        .alert(isPresented: $bVM.showError) {
            Alert(title: Text(Globs.appName), message: Text(bVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    BrandView()
}



//
//import SwiftUI
//
//// BrandView الأساسي
//struct BrandView: View {
//    @Environment(\.dismiss) var dismiss
//    @StateObject var bVM = BrandViewModel.shared
//    var body: some View {
//        ZStack {
//            
//            if bVM.listArr.isEmpty {
//                Text("Brand is Empty")
//                    .font(.customfont(.bold, fontSize: 20))
//            } else {
//                BrandListView(bVM: bVM)
//            }
//            
//            VStack {
//                HeaderView(dismiss: dismiss, onAdd: {
//                    bVM.actionOpenAdd()
//                })
//                Spacer()
//            }
//        }
//        .onAppear {
//            bVM.apiList()
//        }
//        .background(NavigationLink(destination: BrandAddView(), isActive: $bVM.showAddEdit) {
//            EmptyView()
//        })
//        .alert(isPresented: $bVM.showError) {
//            Alert(title: Text(Globs.appName), message: Text(bVM.errorMessage), dismissButton: .default(Text("OK")))
//        }
//        .background(Color.white)
//        .navigationTitle("")
//        .navigationBarBackButtonHidden()
//        .navigationBarHidden(true)
//        .ignoresSafeArea()
//    }
//}
//
//// BrandListView
//struct BrandListView: View {
//    @ObservedObject var bVM: BrandViewModel
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 8) {
//                ForEach(bVM.listArr, id: \.id) { bObj in
//                    BrandItemView(bObj: bObj, onEdit: {
//                        bVM.actionEdit(obj: bObj)
//                    }, onDelete: {
//                        bVM.actionDelete(obj: bObj)
//                    })
//                }
//            }
//            .padding(20)
//            .padding(.top, .topInsets + 46)
//            .padding(.bottom, .bottomInsets)
//        }
//    }
//}
//
//// BrandItemView
//struct BrandItemView: View {
//    @ObservedObject var bObj: BrandModel
//    var onEdit: () -> Void
//    var onDelete: () -> Void
//    
//    var body: some View {
//        HStack {
//            Text(bObj.brandName)
//                .font(.customfont(.medium, fontSize: 17))
//                .frame(maxWidth: .infinity, alignment: .leading)
//            
//            Button(action: {
//                onEdit()
//            }, label: {
//                Image(systemName: "pencil.line")
//                    .foregroundColor(.primaryApp)
//            })
//            
//            Button(action: {
//                onDelete()
//            }, label: {
//                Image(systemName: "trash.fill")
//                    .foregroundColor(.red)
//            })
//        }
//        .frame(height: 50)
//        .padding(.horizontal, 15)
//        .background(Color.white)
//        .cornerRadius(5)
//        .shadow(radius: 2)
//    }
//}
//
//
//// HeaderView
//struct HeaderView: View {
//    var dismiss: DismissAction
//    var onAdd: () -> Void
//    
//    var body: some View {
//        HStack {
//            Button(action: {
//                dismiss()
//            }, label: {
//                Image("back")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//            })
//            .frame(width: 40, height: 40)
//            
//            Text("Brands")
//                .font(.customfont(.bold, fontSize: 20))
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            Button(action: {
//                onAdd()
//            }, label: {
//                Image("add_green")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//            })
//            .frame(width: 40, height: 40)
//        }
//        .padding(.top, .topInsets)
//        .padding(.horizontal, 8)
//        .background(Color.white)
//        .shadow(radius: 2)
//    }
//}
//
//
//// Preview
//#Preview {
//    BrandView()
//}








//import SwiftUI
//
//struct BrandView: View {
//    @Environment(\.dismiss) var dismiss
//    @StateObject var BrandVM = BrandViewModel.shared
//
//    var body: some View {
//        ZStack {
//
//            if BrandVM.listArr.isEmpty {
//                Text("Brand List Empty")
//                    .font(.customfont(.bold, fontSize: 20))
//            }
//
//            ScrollView {
//                LazyVStack(spacing: 8) {
//                    ForEach(BrandVM.listArr, id: \.id) { item in
//                        brandRow(item: item)
//                    }
//                }
//                .padding(20)
//                .padding(.top, .topInsets + 46)
//                .padding(.bottom, .bottomInsets)
//            }
//
//        }
//        .background(Color.white)
//        .navigationTitle("")
//        .navigationBarBackButtonHidden()
//        .ignoresSafeArea()
//    }
//
//    // فصل جزء الـ row لتسهيل التحقق من الأنواع
// في هذا المثال، استخدمت @ViewBuilder للسماح بإرجاع أكثر من نوع عرض (Text أو HStack) بناءً على شرط معين.
//@ViewBuilder
//private func brandRow(item: Brand) -> some View {
//    if item.brandName.isEmpty {
//        Text("No Brand Name")
//    } else {
//        HStack {
//            Text(item.brandName)
//                .font(.customfont(.medium, fontSize: 17))
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//            Button(action: {
//                BrandVM.actionEditBrand(obj: item)
//            }, label: {
//                Image(systemName: "chevron.right")
//                    .formStyle(Color.primaryApp)
//            })
//        }
//        .frame(height: 50)
//        .padding(.horizontal, 15)
//        .background(Color.white)
//        .cornerRadius(5)
//        .shadow(radius: 2)
//    }
//}
//
//#Preview {
//    BrandView()
//}
