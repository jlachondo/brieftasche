//
//  TextFieldView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var text: String

    var fieldPlaceholder: String = "Email"
    var isPasswordField: Bool = false
    var shouldAutoCapitalize: Bool = false
    
    var body: some View {
        if !isPasswordField {
            TextField(fieldPlaceholder, text: $text)
                .padding()
                .background(UIConfig.secondaryBtnBGMaterial)
                .cornerRadius(10)
                .font(UIConfig.regularFont)
                .textInputAutocapitalization(shouldAutoCapitalize == false ? .never : .sentences)
        } else {
            SecureField(fieldPlaceholder, text: $text)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .font(UIConfig.regularFont)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
//        Use `.constant(...)` to run a view with binding
        TextFieldView(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
