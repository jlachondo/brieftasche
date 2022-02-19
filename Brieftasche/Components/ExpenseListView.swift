//
//  ExpenseListView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import SwiftUI

struct ExpenseListView: View {
    
    var category: String = "Coffee"
    var note: String?
    var amount: Double = 0.00
    var recordedAt: String = "05:40 PM"
    
    var body: some View {
        HStack {
            Text(getExpenseCategory(category: category))
                .font(.system(size: 32))
            VStack(alignment: .leading) {
                Text(category)
                    .foregroundColor(UIConfig.primaryFontColor)
                    .font(UIConfig.regularFont)
                    .lineLimit(1)
                if note != nil {
                    Text(note ?? "")
                        .foregroundColor(Color(.systemGray2))
                        .font(UIConfig.xSmallFont)
                        .lineLimit(2)
                }
            }
            Spacer(minLength: 30)
            VStack(alignment: .trailing) {
                Text("₱\(amount, specifier: "%.2f")")
                    .foregroundColor(UIConfig.primaryFontColor)
                    .font(UIConfig.regularFont)
                    .lineLimit(1)
                Text("\(recordedAt)")
                    .foregroundColor(Color(.systemGray2))
                    .font(UIConfig.xSmallFont)
                    .lineLimit(1)
            }
        }
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView().previewLayout(.sizeThatFits)
    }
}
