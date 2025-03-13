//
//  View+Extension.swift
//  UI
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Core
import SwiftUI

public extension View {
    
    func backgroundRoundedRectangle() -> some View {
        self.background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.inactiveBorder)
                .foregroundStyle(.clear)
        }
    }
    
    func textRoundedRectangle(_ isFocused: Bool = false) -> some View {
        self.frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? .primaryColor : Color.inactiveBorder,
                            lineWidth: isFocused ? 2 : 1)
                    .frame(height: 46)
            )
    }
    
    func datePickerRectangle(_ date: Date) -> some View {
        self.labelsHidden()
            .colorMultiply(.clear)
            .overlay {
                Text(date, formatter: DateFormatter().yearAndDay)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .textRoundedRectangle()
            .tint(.primaryColor)
    }
    
    func transparentFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(BackgroundClearView())
        }
    }
    
    func expandTouchArea(_ size: CGFloat = 20) -> some View {
        self.modifier(ExpandTouchArea(size: size))
    }
    
    func basicAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryButtonTitle: String,
        secondaryButtonTitle: String? = nil,
        primaryButtonAction: ( () -> Void)? = nil,
        secondaryButtonAction: ( () -> Void)? = nil
    ) -> some View {
        let alert = BasicAlertView(
            isPresented: isPresented,
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            secondaryButtonTitle: secondaryButtonTitle,
            primaryButtonAction: primaryButtonAction,
            secondaryButtonAction: secondaryButtonAction
        )
        
        return modifier(BasicAlertModifier(isPresented: isPresented, alert: alert))
    }
    
    func backNavagationToolbar(action: @escaping () -> Void) -> some View {
        return self.modifier(BackNavigationToolbarModifier(action: action))
    }
}
