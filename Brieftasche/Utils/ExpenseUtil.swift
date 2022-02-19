//
//  ExpenseUtil.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Foundation

let emojis: [String: String] = [
    "Accessories": "💍",
    "Books": "📗",
    "Cafes & Restaurants": "🍽",
    "Car": "🚗",
    "Charity": "🎗",
    "Clothing": "👕",
    "Coffee": "☕️",
    "Drinks": "🍹",
    "Emergency": "🚑",
    "Entertainment": "🍿",
    "Food": "🍜",
    "Gifts": "🎁",
    "Groceries": "🛒",
    "Home": "🏠",
    "Hospital": "🏥",
    "Loans": "💵",
    "Medicine": "💊",
    "Personal Care": "🧻",
    "Pets": "🐶",
    "Snacks": "🍪",
    "Sports": "🚵🏽‍♀️",
    "Subscription": "📅",
    "Taxi": "🚕",
    "Tech": "📱",
    "Transport": "🚌",
    "Vacation": "🏝",
]

func getExpenseCategory(category: String) -> String {
    return emojis[category] ?? "❌"
}
