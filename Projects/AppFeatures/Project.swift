//
//  Project.swift
//  Manifests
//
//  Created by abc on 3/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    module: .features,
    product: .framework,
    targetDependencies: [
        .project(target: Module.ui.name, path: Module.ui.path)
    ]
)
