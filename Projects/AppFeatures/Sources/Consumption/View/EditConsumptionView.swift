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
    
    @State private var id: UUID
    @State private var title: String = ""
    @State private var amount: Decimal = 0
    @State private var category: ExpenseCategory = .food
    @State private var isPositive: Bool = false
    @FocusState private var isFocused: Bool
    
    init(viewModel: ConsumptionMainViewModel, consumptionID: UUID) {
        self.viewModel = viewModel
        self.id = consumptionID
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
                    .focused($isFocused)
            }
            HStack {
                Text("Amount")
                    .bold()
                    .frame(width: 80, alignment: .leading)
                AmountTextField("\(currency.currencySymbol) 0", value: $amount, currency: .constant(currency))
                    .focused($isFocused)
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
        .onAppear {
            guard let consumption = viewModel.fetchConsumption(id: id) else {
                return
            }
            title = consumption.title
            amount = consumption.amount
            category = ExpenseCategory(rawValue: consumption.tag) ?? .food
            isPositive = consumption.amount > 0 ? true : false
        }
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
                .disabled(!isPositive || isFocused)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    @Previewable @State var consumption = Consumption(title: "Test", date: Date(), amount: 10, tag: "Health")
    EditConsumptionView(viewModel: ConsumptionMainViewModel(), consumptionID: consumption.id)
        .environmentObject(router)
}
