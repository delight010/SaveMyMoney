//
//  BasicAlertModifier.swift
//  UI
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct BasicAlertModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    
    let alert: BasicAlertView
    
    public func body(content: Content) -> some View {
        content
            .transparentFullScreenCover(isPresented: $isPresented) {
                alert
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}
