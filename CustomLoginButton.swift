//
//  CustomLoginButton.swift
//  pointerup-customer
//
//  Created by apzzo on 04/11/24.
//

import SwiftUI
import Combine

//#Preview {
//    LoginButtonView()
//}

struct ForgotPasswordView: View {
//    @Bindable var viewModel: LoginViewModel
    @Bindable var textProperty: Property
    @State var navigateToForgotPassword = false
    @EnvironmentObject var allScreenLayoutModel: AllScreenUiViewModel
    var componentIds = [String]()
//    @Binding var presentLogin: Bool
    
    var body: some View {
//        let title = viewModel.uiModel.ninthProperty
        let name = textProperty.firstProperty
        HStack {
            Spacer()
            Button(action: {
                navigateToForgotPassword = true
            }) {
                Text(name?.data ?? "")
                    .font(.custom(name?.style.getFont ?? "Inter-SemiBold", size: name?.style.getFontSize ?? 14))
                    .foregroundColor(Color(hex: name?.style.color ?? "FFFFFF"))
            }
        }
    }
}


struct LoginButtonView: View {
    @Bindable var viewModel: LoginViewModel
    let titleProperty: Property
    let borderProperty: Property
    let bgProperty: Property
    let type: AuthenticationType
    var cornerRadius:CGFloat = 10
    var isFromProductList = false
    @State var navigate = false
    @EnvironmentObject var allScreenLayoutModel: AllScreenUiViewModel
    
    var body: some View {
        Button(action: {
            switch type {
            case .LOGIN:
                return viewModel.validateLogin()
            case .OTP:
                return viewModel.validateOTP()
            case .SIGNUP:
                return viewModel.validateForSignUp()
            case .FORGOTPASSWORD:
                return viewModel.validateEmail(isFromLogin: false)
            }
        }) {
            Text(titleProperty.data)
                .font(.custom(titleProperty.style.getFont, size: titleProperty.style.getFontSize))
                .foregroundColor(Color(hex: titleProperty.style.color))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color(hex: bgProperty.style.color))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: borderProperty.style.color), lineWidth: borderProperty.style.getSize)
                )
        }
    }
    
    private func getScreen() -> some View {
        switch type {
        case .LOGIN:
            return AnyView(TBR001())
        case .OTP:
            return AnyView(SL0112View(viewModel: viewModel))
        case .SIGNUP:
            return AnyView(SL0001View())
        case .FORGOTPASSWORD:
            return AnyView(SL0001View())
        }
    }
}

struct SignUpButtonView: View {
    @Bindable var viewModel: LoginViewModel
    @State var navigateToSignup = false
    
    let titleProperty: Property
    let subTitleProperty: Property
    let type: AuthenticationType
    var showUnderline: Bool = false
    @EnvironmentObject var allScreenLayoutModel: AllScreenUiViewModel
    
    var body: some View {
        /// Sign up Button
        HStack {
            Spacer()
            PUTextView(property: subTitleProperty)
            Button(action: {
                navigateToSignup = true
            })
            {
                PUTextView(property: titleProperty)
                    .underline(showUnderline)
            }
            Spacer()
        }
        .background(
            NavigationLink(destination: getScreen().environmentObject(allScreenLayoutModel)
                .navigationBarHidden(true),
                           isActive: $navigateToSignup,
                           label: { EmptyView() })
        )
    }
    private func getScreen() -> some View {
        switch type {
        case .LOGIN:
            return AnyView(SL0007View())
        case .OTP:
            return AnyView(TBR001())
        case .SIGNUP:
            return AnyView(SL0001View())
        case .FORGOTPASSWORD:
            return AnyView(SL0001View())
        }
    }
}



