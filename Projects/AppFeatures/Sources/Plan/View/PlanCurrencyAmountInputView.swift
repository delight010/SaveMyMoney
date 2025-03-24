//
//  PlanCurrencyAmountInputView.swift
//  Features
//
//  Created by abc on 3/8/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore
import AppUI
import SwiftUI

public struct PlanCurrencyAmountInputView: View {
    @EnvironmentObject private var router: AppRouter
    @Environment(\.locale) var locale
    
    @ObservedObject private var viewModel: PlanBuilderViewModel
    
    @State private var isPositive: Bool = false
    @State private var selectedCurrency: Currency = Currency.currencies[0]
    @State private var amount: Decimal = 0
    
    private let progress = 0.66
    
    public init(viewModel: PlanBuilderViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            ProgressView(value: progress)
                .tint(.progressBarColor)
                .padding()
            
            Text("select_currency_and_enter_amount")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("currency")
                    .bold()
                Picker("", selection: $selectedCurrency) {
                    ForEach(Currency.currencies) { currency in
                        Text("\(currency.flag) \(currency.code)").tag(currency)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .pickerStyle(.menu)
                .tint(.primary)
                .labelsHidden()
                .textRoundedRectangle()
                .disabled(!viewModel.isSwiftDataPlanEmpty())
                
                Text("amount")
                    .bold()
                    .padding(.top, 5)
                AmountTextField("\(selectedCurrency.currencySymbol) 0", value: $amount, currency: $selectedCurrency)
                    .id(selectedCurrency)
                
                Group {
                    Text("positive_amount_only")
                    if !viewModel.isSwiftDataPlanEmpty() {
                        Text("currency_change_reset_instruction")
                    }
                }
                .foregroundStyle(.secondary)
                
            } // VStack
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                viewModel.setCurrency(selectedCurrency)
                viewModel.setBudget(amount)
                router.push(to: PlanBuildCoordinator.PlanBuildDestination.confirmation)
            } label: {
                Text("button_next")
            }
            .buttonStyle(BottomButtonStyle())
            .disabled(!isPositive)
        } // VStack
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 20)
        .onChange(of: amount) { _, newValue in
            isPositive = newValue > 0 ? true : false
        } // onChange
        .backNavagationToolbar {
            router.pop()
        }
        .onAppear {
            fetchCurrency()
        } // onAppear
    }
}

extension PlanCurrencyAmountInputView {
    
    func fetchCurrency() {
        let identifier = locale.currency?.identifier ?? "en_US"
        selectedCurrency = Currency.currenciesDictionary[identifier] ?? Currency.currencies[0]
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    PlanCurrencyAmountInputView(viewModel: PlanBuilderViewModel())
        .environmentObject(router)
}
