//
//  CustomTextField.swift
//  UI
//
//  Created by abc on 3/14/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Core
import SwiftUI

public struct CustomTextField: View {
    let titleKey: LocalizedStringKey
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    
    private let padding: CGFloat = 12
    
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>) {
        self.titleKey = titleKey
        self._text = text
    }
    
    public var body: some View {
        HStack {
            TextField(titleKey, text: $text)
                .multilineTextAlignment(.trailing)
                .focused($isFocused)
        } // HStack
        .padding(padding)
        .foregroundColor(.primary)
        .textRoundedRectangle(isFocused)
    }
}

#Preview {
    @Previewable @State var text = "Hello"
    CustomTextField("Title", text: $text)
}
