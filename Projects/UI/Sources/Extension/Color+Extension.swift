//
//  Color+Extension.swift
//  UI
//
//  Created by abc on 3/7/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUICore

public extension Color {
    static let primaryColor = Color("Primary", bundle: Bundle.module)
    static let secondaryColor = Color("Secondary", bundle: Bundle.module)
    static let progressBArColor = Color("ProgressBar", bundle: Bundle.module)
    
    // Bottom Button
    static let pressedButtonBackground = Color("PressedButtonBackground", bundle: Bundle.module)
    static let disabledButtonBackground = Color("DisabledButtonBackground", bundle: Bundle.module)
    static let buttonText = Color("ButtonText", bundle: Bundle.module)
    static let disabledButtonText = Color("DisabledButtonText", bundle: Bundle.module)
    
    // Text, TextField
    static let inactiveBorderColor = Color("InactiveBorderColor", bundle: Bundle.module)
}
