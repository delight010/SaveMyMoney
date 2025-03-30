//
//  DismissKeyboardOnTap.swift
//  AppUI
//
//  Created by abc on 3/30/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

struct DismissKeyboardOnTap: ViewModifier {
    
    var gesture: some Gesture {
        TapGesture().onEnded { _ in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .gesture(gesture)
    }
}
