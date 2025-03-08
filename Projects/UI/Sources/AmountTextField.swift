//
//  AmountTextField.swift
//  UI
//
//  Created by abc on 3/8/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Core
import SwiftUI

public struct AmountTextField: View {
    let titleKey: LocalizedStringKey
    @Binding var value: Decimal
    @Binding var currency: Currency
    @State var valueString: String = ""
    
    @FocusState private var isFocused: Bool
    
    private let cornerRadius: CGFloat = 8
    private let padding: CGFloat = 12
    
    public init(_ titleKey: LocalizedStringKey, value: Binding<Decimal>, currency: Binding<Currency>) {
        self.titleKey = titleKey
        self._value = value
        self._currency = currency
    }
    
    public var body: some View {
        HStack {
            TextField(titleKey, text: $valueString)
                .multilineTextAlignment(.trailing)
                .focused($isFocused)
                .keyboardType(.decimalPad)
                .onChange(of: isFocused) {
                    if isFocused {
                        valueString = filterDecimal(valueString)
                    } else {
                        convertStringToDecimal()
                    }
                }
                .onChange(of: valueString) {
                    if isFocused {
                        valueString = validateDecimalFormat(valueString)
                    }
                }
        } // HStack
        .padding(padding)
        .foregroundColor(.primary)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isFocused ? .primaryColor : Color.inactiveBorder,
                        lineWidth: isFocused ? 2 : 1)
        )
    }
}

extension AmountTextField {
    
    func filterDecimal(_ input: String) -> String {
        return input.filter { "0123456789.".contains($0) }
    }
    
    func convertStringToDecimal() {
        if valueString.isEmpty {
            value = 0
            valueString = ""
            return
        }
        
        if let amount = Decimal(string: filterDecimal(valueString)) {
            value = amount
            valueString = currency.formatStyle().format(amount)
        }
    }
    
    func validateDecimalFormat(_ newValue: String) -> String {
        let decimal = filterDecimal(newValue)
        let normalizeLeadingZero = normalizeLeadingZero(decimal)
        let singleDecimalPoint = makeSingleDecimalPoint(normalizeLeadingZero)
        let limitedDecimalPlaces = limitDecimalPlaces(singleDecimalPoint, maxPlaces: currency.decimals)
        return limitedDecimalPlaces
    }
    
    private func normalizeLeadingZero(_ input: String) -> String {
        var result = input
        if result.hasPrefix("0") && result.count > 1 {
            let secondChar = result[result.index(after: result.startIndex)]
            if secondChar != "." {
                result.removeFirst()
            }
        }
        return result
    }
    
    private func makeSingleDecimalPoint(_ input: String) -> String {
        let decimalPoints = input.filter { $0 == "." }.count
        if decimalPoints <= 1 {
            return input
        } else {
            let components = input.components(separatedBy: ".")
            return components[0] + (components.count > 1 ? "." + components[1] : "")
        }
    }
    
    private func limitDecimalPlaces(_ input: String, maxPlaces: Int = 2) -> String {
        guard let dotIndex = input.firstIndex(of: ".") else {
            return input
        }
        
        let decimalPlaces = input.distance(from: dotIndex, to: input.endIndex) - 1
        
        if decimalPlaces > maxPlaces {
            let maxLength = input.distance(from: input.startIndex, to: dotIndex) + maxPlaces + 1
            return String(input.prefix(maxLength))
        }
        
        return input
    }
}

#Preview {
    @Previewable @State var amount: Decimal = 0
    @Previewable @State var currency = Currency.currencies[2]
    
    AmountTextField("\(currency.currencySymbol) 0", value: $amount, currency: $currency)
}
