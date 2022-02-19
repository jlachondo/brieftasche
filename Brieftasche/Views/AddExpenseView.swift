//
//  AddExpenseView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.systemRed))
                    .font(.system(size: 14))
                    .padding(.trailing, 5)
                Text("Cancel")
                    .foregroundColor(Color(.systemRed))
                    .font(UIConfig.regularFont)
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello, Expenses!")
            // TODO: Text comp with underline for amount input
            // TODO: Add note text field at the top of num pad - limit 2 lines
            // TODO: Divider comp
            // TODO: Expense: <Button - will trigger the `sheet - half and scrollable` then show the expenses list> (left side above the num pad)
            // TODO: Save button - call the firestore to save it with the current timestamp. After save, go back to the previous screen. (right side above the num pad)
            // TODO: Divider comp
            // TODO: Num pad (create a component for this)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
//                    Image(systemName: "sun.min.fill")
                    Text("Expense")
                        .foregroundColor(UIConfig.primaryFontColor)
                        .font(UIConfig.regularFont)
                }
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
