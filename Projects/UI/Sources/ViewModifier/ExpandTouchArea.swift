//
//  ExpandTouchArea.swift
//  UI
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

struct ExpandTouchArea: ViewModifier {
    var size: CGFloat
    
    init(size: CGFloat = 20) {
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .padding(size)
    }
}
