//
//  Project.swift
//  Config
//
//  Created by abc on 3/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: Plist.Value] = [
    // Bundle identification and configuration
    "CFBundleVersion": "1",
    "CFBundleShortVersionString": "1.0.0",
    "CFBundleDisplayName": "\(AppConfiguration.appName)",
    
    // Localization settings
    "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
    "CFBundleLocalizations": ["en", "ko"],
    "CFBundleAllowMixedLocalizations": true,
    
    // UI and launch settings
    "UILaunchStoryboardName": "LaunchScreen",
    "UIRequiresFullScreen": true,
    "UIStatusBarHidden": false,
    "UIViewControllerBasedStatusBarAppearance": false,
    
    // Device orientation support
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "UISupportedInterfaceOrientations~ipad": ["UIInterfaceOrientationPortrait"],
    
    // Network settings
    "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
]

let project = Project.create(
    module: .app,
    product: .app,
    infoPlist: .extendingDefault(with: infoPlist),
    targetDependencies: [
        .project(target: Module.features.name, path: Module.features.path)
    ]
)
