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

public struct AddConsumptionView: View {
    @EnvironmentObject private var router: AppRouter
    @ObservedObject var viewModel: ConsumptionMainViewModel
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @State private var title: String = ""
    @State private var amount: Decimal = 0
    @State private var category: ExpenseCategory = .food
    @State private var isPositive: Bool = false
    
    public init(viewModel: ConsumptionMainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("date".localized(in: .module))
                    .bold()
                Spacer()
                Text(viewModel.getDate())
            } // HStack
            HStack {
                Text("title".localized(in: .module))
                    .bold()
                    .frame(width: 80, alignment: .leading)
                Spacer()
                CustomTextField("", text: $title)
            }
            HStack {
                Text("amount".localized(in: .module))
                    .bold()
                    .frame(width: 80, alignment: .leading)
                AmountTextField("\(currency.currencySymbol) 0", value: $amount, currency: .constant(currency))
            }
            HStack {
                Text("category".localized(in: .module))
                    .bold()
                    .frame(width: 80, alignment: .leading)
                Picker(category.localizedName, selection: $category) {
                    ForEach(ExpenseCategory.allCases) { category in
                        Label(category.localizedName, systemImage: category.icon).tag(category)
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
        .navigationTitle("add_consumption".localized(in: .module))
        .navigationBarTitleDisplayMode(.inline)
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
                    viewModel.addConsumption(
                        Consumption(
                            title: title,
                            date: viewModel.getDate(),
                            amount: amount,
                            tag: category.rawValue
                        )
                    )
                    
                    if viewModel.isAmountWithinBudget(amount: amount) {
                        router.pop()
                    } else {
                        router.push(to: ConsumptionCoordinator.ConsumptionDestination.failure)
                    }
                } label: {
                    Text("done".localized(in: .module))
                }
                .tint(isPositive ? Color.primaryColor : Color.disabledButtonBackground)
                .disabled(!isPositive)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    AddConsumptionView(viewModel: ConsumptionMainViewModel())
        .environmentObject(router)
}
