//
//  DashboardView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject private var expenseVM = ExpenseViewModel()

    let calendar = Calendar.current
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Add expense button
                HStack {
                    Spacer()
                    NavigationLink(destination: AddExpenseView()) {
                        Image(systemName: "plus")
                            .resizable()
                            .padding(6)
                            .frame(width: 36, height: 36)
                            // .background(Color.black)
                            .background(UIConfig.primaryBtnBGColor)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))

                // Total expense label
                HStack(spacing: 20) {
                    VStack(spacing: 0) {
                        Text("Spent this day")
                            .foregroundColor(Color(.systemGray))
                            .font(UIConfig.regularFont)
                        HStack(alignment: .top, spacing: 0) {
                            Text("₱")
                                .foregroundColor(Color(.systemGray3))
                                .font(UIConfig.mediumFont)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 5))
                            Text("\(expenseVM.totalExpenses, specifier: "%.2f")")
                                .foregroundColor(UIConfig.primaryFontColor)
                                .font(UIConfig.xxLargeFont)
                                .lineLimit(1)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .padding()
                .background(Color(UIConfig.primaryBgColor))

                // Expenses list view
                listView
    //            .refreshable {
    //                await Task.sleep(2_000_000_000)
    //                print("Something about refreshable")
    //            }
    //            .onAppear {
    //                UIRefreshControl.appearance().tintColor = UIColor.red
    //                UIRefreshControl.appearance().backgroundColor = .green.withAlphaComponent(0.5)
    //                UIRefreshControl.appearance().attributedTitle = try? NSAttributedString(markdown: "**Some** cool *title*")
    //            }
                .listStyle(InsetListStyle())
            }
            .onAppear {
                let year = getCurrYear(calendar: calendar)
                let month = getCurrMonth(calendar: calendar)
                let week = getCurrWeekOfYear(calendar: calendar)
                let day = getCurrDay(calendar: calendar)
                print("\(year)/\(month)/\(week)/\(day) - fetchExpenses")
                expenseVM.fetchExpenses(year: year, month: month, week: week, day: day)
            }
        }
    }
    
    @ViewBuilder
    var listView: some View {
        if expenseVM.expenses.isEmpty {
            emptyListView
        } else {
            expensesListView
        }
    }

    var emptyListView: some View {
        List {
            Section {
                HStack(alignment: .center) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(.systemGray3))
                        .padding(.trailing, 4)
                    Text("No expense record. To add one, tap the '+' button above.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.systemGray2))
                        .font(UIConfig.smallFont)
                        .lineLimit(2)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("Expenses")
                    .foregroundColor(Color(.systemGray))
                    .font(UIConfig.smallFont)
            }
        }
        .navigationBarHidden(true)
    }

    var expensesListView: some View {
        // List of expenses
        List(Array(expenseVM.expenses.enumerated()), id: \.element.id) { (index, expense) in
            Section {
                ExpenseListView(category: expense.category, note: expense.note, amount: expense.amount, recordedAt: expense.recordedAt)
            } header: {
                Text("Expenses")
                    .foregroundColor(Color(.systemGray))
                    .font(UIConfig.smallFont)
            }
        }
        .navigationBarHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
