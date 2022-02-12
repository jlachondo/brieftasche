//
//  ContentView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/10/22.
//

import Firebase
import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var errorMsg = ""
    @State var isLoading = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                    LogoView(font: UIConfig.brandFont, imageLbl: "Brieftasche")
                    Spacer()
                    if !errorMsg.isEmpty {
                        ErrorMessageView(errorMsg: errorMsg)
                    }
                    Group {
                        TextFieldView(text: $email)
                        TextFieldView(text: $password, fieldPlaceholder: "Password", isPasswordField: true)
                            .padding(.bottom, 25)
                    }
                    ButtonView(isLoading: $isLoading, action: login, text: "Sign In")
                    Spacer()
                    HStack {
                        Text("Don't have an account yet?")
                            .foregroundColor(UIConfig.primaryFontColor)
                            .font(UIConfig.smallFont)
                        Button(action: {
                            viewRouter.currentPage = .signUpScreen
                        }) {
                            Text("Register here")
                                .foregroundColor(UIConfig.tertiaryFontColor)
                                .font(UIConfig.smallFont)
                                .underline()
                        }
                    }
                }
                .padding()
                .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
            }
        }
    }
    
    private func handleLoginProcess(errorMsg: String, isLoading: Bool) {
        self.isLoading = isLoading
        self.errorMsg = errorMsg
    }
    
    private func login() {
        handleLoginProcess(errorMsg: "", isLoading: true)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil, let error = error as NSError? {
                handleLoginProcess(errorMsg: AuthUtil().handleFirAuthError(error: error), isLoading: false)
            } else {
                withAnimation {
                    viewRouter.currentPage = .homeScreen
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
