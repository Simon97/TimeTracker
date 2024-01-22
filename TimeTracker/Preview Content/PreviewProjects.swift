//
//  Projects.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 15/01/2024.
//

import Foundation
import SwiftData

var previewProject: Project = Project(
    "Preview Project",
    isMainProject: true,
    subProjects: [
        Project(
            "Sub project",
            isMainProject: false,
            subProjects: [
                Project(
                    "Sub sub project",
                    isMainProject: false,
                    subProjects: [],
                    tasks: [
                        Task("sub sub project task 1", isFavorite: false)
                    ]
                )],
            tasks: [
                Task("sub project task 1", isFavorite: false)
            ]
        )
    ],
    tasks: [
        Task("task 1", isFavorite: false),
        Task("task 2", isFavorite: false)
    ]
)
