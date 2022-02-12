//
//  SignUpView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import Firebase
import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var confirmPassword = ""
    @State var email = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var password = ""
    @State var errorMsg = ""
    @State var isLoading = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                LogoView(font: UIConfig.brandFont, imageLbl: "Brieftasche")
                Spacer()
                if !errorMsg.isEmpty {
                    ErrorMessageView(errorMsg: errorMsg)
                }
                Group {
                    TextFieldView(text: $firstName, fieldPlaceholder: "First name", shouldAutoCapitalize: true)
                    TextFieldView(text: $lastName, fieldPlaceholder: "Last name", shouldAutoCapitalize: true)
                    TextFieldView(text: $email)
                    TextFieldView(text: $password, fieldPlaceholder: "Password", isPasswordField: true)
                    TextFieldView(text: $confirmPassword, fieldPlaceholder: "Confirm password", isPasswordField: true)
                        .padding(.bottom, 25)
                }
                ButtonView(isLoading: $isLoading, action: register, text: "Register")
                Spacer()
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(UIConfig.primaryFontColor)
                        .font(UIConfig.smallFont)
                    Button(action: {
                        viewRouter.currentPage = .signInScreen
                    }) {
                        Text("Login")
                            .foregroundColor(UIConfig.tertiaryFontColor)
                            .font(UIConfig.smallFont)
                            .underline()
                    }
                }
            }
            .padding()
        }
    }
    
    private func handleRegistrationProcess(errorMsg: String, isLoading: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.isLoading = isLoading
            self.errorMsg = errorMsg
        }
    }
    
    private func register() {
        handleRegistrationProcess(errorMsg: "", isLoading: true)
        
        //        Added async here. The state won't update/the screen won't rerender immediately, without it you'll be stuck in a loading button.
        if firstName.isEmpty {
            handleRegistrationProcess(errorMsg: "First name is required.", isLoading: false)
            //            Semicolon to stop the execution
            return;
        }
        if lastName.isEmpty {
            handleRegistrationProcess(errorMsg: "Last name is required.", isLoading: false)
            return;
        }
        if password != confirmPassword {
            handleRegistrationProcess(errorMsg: "Password and confirm password does not match.", isLoading: false)
            return;
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil, let error = error as NSError? {
                handleRegistrationProcess(errorMsg: AuthUtil().handleFirAuthError(error: error), isLoading: false)
            } else {
                print(result!, "Result")
                //                TODO: Add firestore request here to create a record using the result's uid - record should contain user's: fname, lname, email, isActive??, isVerified??, id??
                withAnimation {
                    viewRouter.currentPage = .homeScreen
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
