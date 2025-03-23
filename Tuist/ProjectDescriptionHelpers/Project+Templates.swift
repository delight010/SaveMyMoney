//
//  Project+Templates.swift
//  Config
//
//  Created by abc on 3/5/25.
//

import ProjectDescription

public extension Project {
    
    static func create(module: Module,
                       product: Product,
                       infoPlist: InfoPlist = .default,
                       targetResources: ResourceFileElements? = nil,
                       targetDependencies: [TargetDependency] = []
    ) -> Project {
        return Project(name: module.name,
                       organizationName: AppConfiguration.organizationName,
                       options: .options(
                        defaultKnownRegions: ["en", "ko", "ja"],
                        developmentRegion: "en"
                       ),
                       settings: .settings(configurations: [
                        .debug(name: AppConfiguration.debugConfig,
                               settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG"]
                              ),
                        .release(name: .release)
                       ]),
                       targets: [
                        Target.create(name: module.name,
                                      product: product,
                                      bundleId: module.bundleId,
                                      infoPlist: infoPlist,
                                      dependencies: targetDependencies
                                     )
                       ]
        )
    }
}
