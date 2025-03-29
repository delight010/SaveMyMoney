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
    
    // Other
    "ITSAppUsesNonExemptEncryption": false
]

public extension TargetScript {
    static let firebaseCrashlytics = TargetScript.post(
        script: """
          "${SRCROOT}/../../Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
          """,
        name: "firebaseCrashlytics",
        inputPaths: [
            "$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME",
            "$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME/Contents/Info.plist",
            "$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME/Contents/Resources/DWARF/$PRODUCT_NAME",
            "$TARGET_BUILD_DIR/$EXECUTABLE_PATH",
            "$TARGET_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH/GoogleService-Info.plist"
        ],
        basedOnDependencyAnalysis: true,
        runForInstallBuildsOnly: false
    )
}

let project = Project.create(
    module: .app,
    product: .app,
    infoPlist: .extendingDefault(with: infoPlist),
    targetscripts: [.firebaseCrashlytics],
    targetDependencies: [
        .project(target: Module.features.name, path: Module.features.path),
        .external(name: "FirebaseAnalytics"),
        .external(name: "FirebaseCrashlytics")
    ]
)
