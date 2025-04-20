//
//  AppConfiguration.swift
//  Config
//
//  Created by abc on 3/5/25.
//

import Foundation
import ProjectDescription

public enum AppConfiguration {
    
    public static let appName: String = "SaveMyMoney"
    public static let organizationName: String = "delight010"
    public static let minimumVersion: String = "17.0"
    public static let bundleIdentifier: String = "\(organizationName).\(appName.lowercased())"
    public static let sources: SourceFilesList = "Sources/**"
    public static let resources: ResourceFileElements = [.glob(pattern: "Resources/**")]
    public static let baseSettings: SettingsDictionary = [
        "OTHER_LDFLAGS": "$(inherited) -ObjC",
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
    ]
    public static let debugConfig: ConfigurationName = "Debug"
}
