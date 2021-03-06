//
//  ExpenseUtil.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Foundation

let emojis: [String: String] = [
    "Accessories": "๐",
    "Books": "๐",
    "Cafes & Restaurants": "๐ฝ",
    "Car": "๐",
    "Charity": "๐",
    "Clothing": "๐",
    "Coffee": "โ๏ธ",
    "Drinks": "๐น",
    "Emergency": "๐",
    "Entertainment": "๐ฟ",
    "Food": "๐",
    "Gifts": "๐",
    "Groceries": "๐",
    "Home": "๐ ",
    "Hospital": "๐ฅ",
    "Loans": "๐ต",
    "Medicine": "๐",
    "Personal Care": "๐งป",
    "Pets": "๐ถ",
    "Snacks": "๐ช",
    "Sports": "๐ต๐ฝโโ๏ธ",
    "Subscription": "๐",
    "Taxi": "๐",
    "Tech": "๐ฑ",
    "Transport": "๐",
    "Vacation": "๐",
]

func getExpenseCategory(category: String) -> String {
    return emojis[category] ?? "โ"
}
