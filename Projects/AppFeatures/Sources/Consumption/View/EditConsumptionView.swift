//
//  EditConsumptionView.swift
//  AppFeatures
//
//  Created by abc on 3/15/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore
import AppUI

import SwiftUI

struct EditConsumptionView: View {
    @EnvironmentObject var router: AppRouter
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @ObservedObject private var viewModel = ConsumptionMainViewModel()
    
    @State private var id: UUID = UUID()
    @State private var title: String
    @State private var amount: Decimal
    @State private var category: ExpenseCategory
    @State private var isPositive: Bool = false
    
    init(viewModel: ConsumptionMainViewModel, consumption: Consumption) {
        self.viewModel = viewModel
        self.id = consumption.id
        self.title = consumption.title
        self.amount = consumption.amount
        self.category = ExpenseCategory(rawValue: consumption.tag) ?? .food
        self.isPositive = consumption.amount > 0
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Date")
                    .bold()
                Spacer()
                Text(viewModel.getDate())
            } // HStack
            HStack {
                Text("Title")
                    .bold()
                    .frame(width: 80, alignment: .leading)
                Spacer()
                CustomTextField("Title", text: $title)
            }
            HStack {
                Text("Amount")
                    .bold()
                    .frame(width: 80, alignment: .leading)
                AmountTextField("\(currency.currencySymbol) 0", value: $amount, currency: .constant(currency))
            }
            HStack {
                Text("Tag")
                    .bold()
                    .frame(width: 80, alignment: .leading)
                Picker("\(category.rawValue)", selection: $category) {
                    ForEach(ExpenseCategory.allCases) { category in
                        Label(category.rawValue, systemImage: category.icon).tag(category)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .tint(Color.primary)
                .pickerStyle(.menu)
            }
            Spacer()
        } // VStack
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .navigationTitle("Edit Consumption")
        .navigationBarBackButtonHidden()
        .onChange(of: amount) { _, newValue in
            isPositive = newValue > 0 ? true : false
        } // onChange
        .toolbar {
            BackNavigationToolbarContent {
                router.pop()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                    router.pop()
                } label: {
                    Text("Done")
                }
                .tint(isPositive ? Color.primaryColor : Color.disabledButtonBackground)
                .disabled(!isPositive)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    @Previewable @State var consumption = Consumption(title: "Test", date: Date(), amount: 10, tag: "Health")
    EditConsumptionView(viewModel: ConsumptionMainViewModel(), consumption: consumption)
        .environmentObject(router)
}
