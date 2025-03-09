//
//  View+Extension.swift
//  UI
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public extension View {
    
    func textRoundedRectangle(_ isFocused: Bool = false) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? .primaryColor : Color.inactiveBorder,
                        lineWidth: isFocused ? 2 : 1)
                .frame(height: 46)
        )
    }
}
