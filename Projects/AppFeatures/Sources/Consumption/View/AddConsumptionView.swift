//
//  AddConsumptionView.swift
//  Features
//
//  Created by abc on 3/14/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftUI

struct AddConsumptionView: View {
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: ConsumptionMainViewModel
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @State private var title: String = ""
    @State private var amount: Decimal = 0
    @State private var category: ExpenseCategory = .food
    
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
        .navigationTitle("Add Consumption")
        .backNavagationToolbar {
            router.pop()
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    AddConsumptionView(viewModel: ConsumptionMainViewModel())
        .environmentObject(router)
}
