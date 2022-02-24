//
//  AddExpenseView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Firebase
import SwiftUI

struct KeyPadRow: View {
    var keys: [String]
    
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButtonView(key: key)
            }
        }
    }
}

struct KeyPad: View {
    @Binding var input: String
    
    var body: some View {
        VStack {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: [".", "0", "⌫"])
        }.environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }
    
    private func keyWasPressed(_ key: String) {
        switch key {
        case "." where input.contains("."): break
        case "." where input == "0": input += key
        case "⌫":
            input.removeLast()
            if input.isEmpty { input = "0" }
        case _ where input == "0": input = key
            //        default: input += key
        default:
            let splitNum = input.split(separator: ".")
            print(splitNum, "splitNum")
            if (input.contains(".") && splitNum.count > 1 && splitNum[1].count >= 2) || input.count >= 16 {
                break
            }
            input += key
        }
    }
}

struct SheetView: View {
    @Binding var isShowingSheet: Bool
    @Binding var selectedCategory: String
    
    let categories = emojis.keys.sorted()
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return VStack {
            HStack {
                Text("Expenses")
                    .foregroundColor(Color(.systemGray))
                    .font(UIConfig.regularFont)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            ScrollView {
                ZStack(alignment: .topLeading) {
                    ForEach(categories, id: \.self) { category in
                        self.item(for: category)
                            .padding(EdgeInsets(top: 15, leading: 4, bottom: 15, trailing: 4))
                            .alignmentGuide(.leading, computeValue: { d in
                                if (abs(width - d.width) > g.size.width) {
                                    width = 0
                                    height -= d.height
                                }
                                let result = width
                                if category == categories.last! {
                                    width = 0 //last item
                                } else {
                                    width -= d.width
                                }
                                return result
                            })
                            .alignmentGuide(.top, computeValue: {d in
                                let result = height
                                if category == categories.last! {
                                    height = 0 // last item
                                }
                                return result
                            })
                    }
                }
                Spacer()
            }
        }
        .frame(width: g.size.width, height: g.size.height)
    }
    
    func item(for category: String) -> some View {
        Button(action: {
            print(category)
            isShowingSheet = false
            selectedCategory = category
        }) {
            VStack {
                Text(getExpenseCategory(category: category))
                    .font(UIConfig.largeFont)
                Text(category)
                    .foregroundColor(UIConfig.primaryFontColor)
                    .font(UIConfig.xSmallFont)
                    .lineLimit(1)
                    .frame(width: 90)
            }
        }
    }
}

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var amount: String = "0"
    @State private var isSaving: Bool = false
    @State private var isShowingSheet = false
    @State private var note: String = ""
    @State private var selectedCategory: String = "Coffee"
    
    private let calendar = Calendar.current
    private let db = Firestore.firestore()
    
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
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    // Amount section
                    VStack {
                        HStack(alignment: .top, spacing: 0) {
                            Text("₱")
                                .foregroundColor(Color(.systemGray3))
                                .font(UIConfig.mediumFont)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 5))
                            Text(amount.withCommas())
                                .foregroundColor(UIConfig.primaryFontColor)
                                .font(UIConfig.xxLargeFont)
                                .lineLimit(2)
                        }
                    }
                    .frame(width: geometry.size.width - 50, height: geometry.size.height / 3)
                    
                    // Add note section
                    Divider()
                    VStack {
                        TextField("Add note", text: $note)
                            .foregroundColor(UIConfig.primaryFontColor)
                            .font(UIConfig.regularFont)
                    }
                    .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
                    
                    // Choose category section
                    Divider()
                    HStack {
                        HStack {
                            Text("Category")
                                .foregroundColor(UIConfig.primaryFontColor)
                                .font(UIConfig.smallFont)
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color(.systemGray2))
                                .font(.system(size: 18))
                                .padding(.horizontal, 10)
                            Button(action: {
                                print("Category")
                                isShowingSheet.toggle()
                            }) {
                                Text("\(getExpenseCategory(category: selectedCategory)) \(selectedCategory)")
                                    .foregroundColor(UIConfig.primaryFontColor)
                                    .font(UIConfig.smallFont)
                                    .lineLimit(1)
                            }
                            .sheet(isPresented: $isShowingSheet) {
                                SheetView(isShowingSheet: $isShowingSheet, selectedCategory: $selectedCategory)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                        ButtonView(isLoading: $isSaving, action: saveExpense, disabled: amount == "0", height: 35, text: "Save", width: 80, font: UIConfig.smallFont)
                            .padding(.leading, 10)
                    }
                    .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
                    Divider()
                    
                    // Numpad section
                    VStack {
                        KeyPad(input: $amount)
                    }
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Expense")
                                .foregroundColor(UIConfig.primaryFontColor)
                                .font(UIConfig.regularFont)
                        }
                    }
                }
            }
        }
    }
    
    private func saveExpense() {
        let docData: [String: Any] = [
            "amount": Double(amount)!,
            "category": selectedCategory,
            "currency": "PHP",
            "note": note,
            "timestamp": Timestamp(date: Date()),
        ]
        
        print(docData, "docData")
        
        let year = getCurrYear(calendar: calendar)
        let month = getCurrMonth(calendar: calendar)
        let week = getCurrWeekOfYear(calendar: calendar)
        let day = getCurrDay(calendar: calendar)
        print("\(year)/\(month)/\(week)/\(day) - createExpense")
        
        let currUser = Auth.auth().currentUser
        
        if let currUser = currUser, !currUser.uid.isEmpty {
            let docRef = db.collection("expenses")
                .document(currUser.uid)
                .collection(year)
                .document(month)
                .collection(week)
                .document(day)
                .collection("allRecords")
                .document()
            
            docRef.setData(docData) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    // TODO: Handle error - display something in the UI
                } else {
                    print("Document successfully written!")
                    self.presentationMode.wrappedValue.dismiss()
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
