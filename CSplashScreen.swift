//
//  SplashScreen.swift
//  pointerup-customer
//
//  Created by Sakthikumar on 19/12/24.
//

import SwiftUI

struct CustomerSplashScreen: View {
    @State var navigate = false
    @EnvironmentObject var viewModel: AllScreenUiViewModel
    @EnvironmentObject var alertViewModel: AlertViewModel
    @EnvironmentObject var homeViewModel: CustomerHomeViewModel
    @EnvironmentObject var manager: NavigationManager
    let versionId: String
    let storeId: String
    
    var body: some View {
        ZStack {
            if navigate {
                TBR001()
                    .environmentObject(viewModel)
                    .environmentObject(homeViewModel)
                    .environmentObject(manager)
                    .transition(.opacity)
                    .animation(.easeInOut, value: navigate)
            } else {
                ZStack {
                    Color(hex: "#1B9AE7")
                    Image("appLogo")
                        .resizable()
                        .frame(width: 250, height: 250)
                }
                .preferredColorScheme(.light)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    Task {
                        await viewModel.fetchAllScreen(storeId: storeId, versionId: versionId)
                    }
                }
            }
        }
//        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden()
        .onChange(of: viewModel.homeProductList) {
            if viewModel.isDataLoaded {
                withAnimation(.smooth(duration: 0.5)) {
                    navigate = true
                }
            }
        }
        .onChange(of: viewModel.navigationFromStoreXplore) { oldValue, newValue in
            if !viewModel.navigationFromStoreXplore {
                navigate = false
            }
        }
        .navigationBarBackButtonHidden()
    }
}
