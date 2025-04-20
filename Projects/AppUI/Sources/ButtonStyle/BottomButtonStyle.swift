//
//  BottomButtonStyle.swift
//  UI
//
//  Created by abc on 3/7/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct BottomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(
                isEnabled
                ? Color.buttonText : Color.disabledButtonText
            )
            .background(
                isEnabled
                ? (configuration.isPressed ? Color.pressedButtonBackground : Color.primaryColor)
                : Color.disabledButtonBackground
            )
            .cornerRadius(10)
    }
}
