//
//  ExpandTouchArea.swift
//  UI
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

struct ExpandTouchArea: ViewModifier {
    var edges: Edge.Set
    var size: CGFloat
    
    init(_ edges: Edge.Set = .all, size: CGFloat = 20) {
        self.edges = edges
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .padding(edges, size)
    }
}
