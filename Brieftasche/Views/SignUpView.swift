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
                            .foregroundColor(Color(.systemBlue))
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
    
    private func setUserData(document: String, docData: [String: Any]) {
        let db = Firestore.firestore()
        
        db.collection("users").document(document).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
                handleRegistrationProcess(errorMsg: "Something went wrong while creating user data, please try again.", isLoading: false)
            } else {
                print("Document successfully written!")
                withAnimation {
                    viewRouter.currentPage = .homeScreen
                }
            }
        }
    }
    
    private func register() {
        handleRegistrationProcess(errorMsg: "", isLoading: true)
        
        // Added async here. The state won't update/the screen won't rerender immediately, without it you'll be stuck in a loading button.
        if firstName.isEmpty {
            handleRegistrationProcess(errorMsg: "First name is required.", isLoading: false)
            // Semicolon to stop the execution
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
                guard let res = result else { return }
                print(res)
                let id = res.user.uid
                let docData: [String: Any] = [
                    "email": res.user.email!,
                    "firstName": firstName,
                    "id": id,
                    "isActive": true,
                    "isEmailVerified": res.user.isEmailVerified,
                    "lastName": lastName,
                    "timestamp": Timestamp(date: Date()),
                ]
                print(docData)
                setUserData(document: id, docData: docData)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
