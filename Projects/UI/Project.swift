//
//  Project.swift
//  Manifests
//
//  Created by abc on 3/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    module: .ui,
    product: .framework,
    targetDependencies: [
        .project(target: Module.core.name, path: Module.core.path)
    ]
)
