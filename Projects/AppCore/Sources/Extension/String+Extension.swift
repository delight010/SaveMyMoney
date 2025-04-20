//
//  String+Extension.swift
//  AppCore
//
//  Created by abc on 3/24/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

public extension String {
    func localized(in bundle: Bundle) -> String {
        return String(localized: LocalizationValue(self), bundle: bundle)
    }
}
