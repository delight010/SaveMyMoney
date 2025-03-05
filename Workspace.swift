//
//  Workspace.swift
//  Manifests
//
//  Created by abc on 3/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: AppConfiguration.appName,
    projects: [
        "./Projects/**"
    ]
)
