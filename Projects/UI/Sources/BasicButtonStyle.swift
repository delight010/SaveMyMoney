//
//  BasicButtonStyle.swift
//  UI
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct BasicButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .imageScale(.large)
            .bold()
            .foregroundStyle(configuration.isPressed ? Color.pressedButtonBackground : Color.primaryColor)
            .tint(Color.primaryColor)
            .expandTouchArea()
    }
}
