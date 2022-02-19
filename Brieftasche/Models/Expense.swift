//
//  Expense.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Foundation

struct Expense: Codable, Identifiable {

    let id: String
    let category: String
    let note: String?
    let amount: Double
    let timestamp: Date
    var recordedAt: String {
        let dateFormatter = getDateFormatter()
        return dateFormatter.string(from: timestamp)
    }
    
    init(docData: [String: Any]) {
        self.id = docData["id"] as? String ?? UUID().uuidString
        self.category = docData["category"] as? String ?? ""
        self.note = docData["note"] as? String ?? ""
        self.amount =  docData["amount"] as? Double ?? 0.00
        self.timestamp = docData["timestamp"] as? Date ?? Date()
    }
}
