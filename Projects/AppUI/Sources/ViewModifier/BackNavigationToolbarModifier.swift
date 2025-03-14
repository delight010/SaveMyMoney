//
//  BackNavigationToolbarModifier.swift
//  UI
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

struct BackNavigationToolbarModifier: ViewModifier {
    
    var action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                BackNavigationToolbarContent(action: action)
            }
            .navigationBarBackButtonHidden()
    }
}
