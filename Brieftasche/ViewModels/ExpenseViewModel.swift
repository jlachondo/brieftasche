//
//  ExpenseViewModel.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Firebase

class ExpenseViewModel: ObservableObject {
    
    @Published var expenses = [Expense]()
    @Published var totalExpenses = 0.00
    
    private var db = Firestore.firestore()
    
    func fetchExpenses(year: String, month: String, week: String, day: String) {
        let currUser = Auth.auth().currentUser
        if let currUser = currUser, !currUser.uid.isEmpty {
            db.collection("expenses")
                .document(currUser.uid)
                .collection(year)
                .document(month)
                .collection(week)
                .document(day)
                .collection("allRecords")
                .order(by: "timestamp", descending: true)
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents - fetchExpenses")
                        return
                    }
                    
                    // Reset total expenses on snapshot update
                    self.totalExpenses = 0.00
                    
                    self.expenses = documents.map { (queryDocumentSnapshot) -> Expense in
                        let data = queryDocumentSnapshot.data()
                        let docId = queryDocumentSnapshot.documentID
                        let amount = data["amount"]
                        let category = data["category"]
                        let note = data["note"]
                        let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                        
                        print(docId, "docId")
                        print(data, "data")
                        
                        // Return immediately if there's no id or amount
                        if docId.isEmpty || amount == nil {
                            return Expense(docData: [:])
                        }
                        
                        // Update total expenses and create docData
                        let expenseAmount = amount as? Double ?? Double(amount as! String)!
                        print(expenseAmount, "expenseAmount")
                        self.totalExpenses += expenseAmount
                        
                        let docData: [String: Any] = [
                            "id": docId,
                            "category": category!,
                            "note": note ?? "",
                            "amount": expenseAmount,
                            "timestamp": timestamp,
                        ]
                        
                        return Expense(docData: docData)
                    }
                }
        }
    }
}
