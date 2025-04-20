//
//  BackNavigationToolbarContent.swift
//  UI
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct BackNavigationToolbarContent: ToolbarContent {
    
    var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                action()
            } label: {
                Image(systemName: "chevron.backward")
            }
            .tint(Color.primaryColor)
            .expandTouchArea(size: 10)
        }
    }
}
