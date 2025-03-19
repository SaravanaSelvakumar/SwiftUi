//
//  Untitled.swift
//  pointerup-customer
//
//  Created by apzzo on 04/11/24.
//
import SwiftUI

struct EmailTextField: View {
    @Bindable var viewModel: LoginViewModel
    var textFieldCornerRadius: CGFloat = 10
    var emailLineWidth: CGFloat = 1
    let keyboardType: UIKeyboardType = .emailAddress
    @FocusState private var focusedField: CustomerTextField?
    let titleProperty : Property
    let fieldProperty : Property
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(titleProperty.data)
                .font(.custom(titleProperty.style.getFont, size: titleProperty.style.getFontSize))
                .foregroundStyle(Color(hex: titleProperty.style.color))
                .padding(.bottom, 2)
            
            CustomTextFieldCustomer(
                PlaceHolder: fieldProperty.data,
                emailBorderColor: "6A6A6A",
                emailTFColor: fieldProperty.style.color,
//                emailBorderColor: "EDF1F3",
                fontType: fieldProperty.style.getFont,
                fontSize: fieldProperty.style.getFontSize,
                emailLineWidth: emailLineWidth,
                textFieldCornerRadius: textFieldCornerRadius,
                keyboardType: keyboardType,
                email: $viewModel.email
            )
        }
        
    }
}

struct PasswordTextField: View {
    @State private var isPasswordVisible: Bool = false
    @Binding var password: String
    var textFieldCornerRadius: CGFloat = 10
    @FocusState private var focusedField: SignUpTextField?
    let keyboardType: UIKeyboardType
    let titleProperty : Property
    let fieldProperty : Property
    
    var body: some View {
            
            /// Password Text field
            VStack(alignment: .leading) {
                Text(titleProperty.data)
                    .font(.custom(titleProperty.style.getFont, size: titleProperty.style.getFontSize))
                    .foregroundStyle(Color(hex: titleProperty.style.color))
                    .padding(.bottom, 2)
                
                ZStack {
                    HStack {
                        
                        if isPasswordVisible {
                            TextField(fieldProperty.data, text: $password)
                                .placeholder(when: password.isEmpty) {
                                      Text(fieldProperty.data)
                                        .foregroundColor(Color(hex: "ffffff").opacity(0.2))
//                                        .foregroundColor(Color(hex: fieldProperty.style.color))
                                  }
                                .font(.custom(fieldProperty.style.getFont, size: fieldProperty.style.getFontSize))
                                .foregroundStyle(Color(hex: fieldProperty.style.color))
//                                .submitLabel(.done)
                                .keyboardType(keyboardType)
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
//                                .focused($focusedField, equals: .password)
                        } else {
                            SecureField(fieldProperty.data, text: $password)
                                .placeholder(when: password.isEmpty) {
                                      Text(fieldProperty.data)
                                        .foregroundColor(Color(hex: "ffffff").opacity(0.2))
//                                        .foregroundColor(Color(hex: fieldProperty.style.color))
                                  }
                                .font(.custom(fieldProperty.style.getFont, size: fieldProperty.style.getFontSize))
                                .foregroundStyle(Color(hex: fieldProperty.style.color))
//                                .submitLabel(.done)
                                .keyboardType(keyboardType)
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
//                                .focused($focusedField, equals: .password)
                        }
                        
                        Spacer()
                        
//                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash")
                        Image(isPasswordVisible ? "eyeview" : "eyeSlash")
                            .foregroundColor(Color(hex: "ACB5BB"))
                            .onTapGesture {
                                isPasswordVisible.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    focusedField = .password
                                }
                            }
                    }
                }
                .padding(.vertical)
                .padding(.leading)
                .padding(.trailing, 10)
                .background(
                    RoundedRectangle(cornerRadius: textFieldCornerRadius)
//                        .fill(Color(hex: "FFFFFF"))
                        .stroke(Color(hex: "6A6A6A"), lineWidth: 1)
                )
            }
        
    }
}

struct CustomTextFieldCustomer: View {
    
    var PlaceHolder: String
    var emailBorderColor: String
    var emailTFColor: String
    var fontType: String
    var fontSize: CGFloat
    var emailLineWidth: CGFloat
    var textFieldCornerRadius: CGFloat
    var keyboardType: UIKeyboardType
    @Binding var email: String
    
    var body: some View {
        TextField(PlaceHolder, text: $email)
            .placeholder(when: email.isEmpty) {
                  Text(PlaceHolder)
                    .foregroundColor(Color(hex: "ffffff").opacity(0.2))
              }
            .font(.custom(fontType, size: fontSize))
            .keyboardType(keyboardType)
            .foregroundStyle(Color(hex: emailTFColor))
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: textFieldCornerRadius)
//                    .fill(Color(hex: "FFFFFF"))
                    .stroke(Color(hex: emailBorderColor), lineWidth: emailLineWidth)
            )
        
    }
}





