//
//  Projects.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 15/01/2024.
//

import Foundation

var previewProject: Project = Project(
    "Preview Project",
    subProjects: [Project("Another One", subProjects: [], tasks: [Task("Fix stuff")])],
    tasks: [
        Task("Make tests"),
        Task("Make SwiftData models")
    ]
)

var previewProject2: Project = Project(
    "Preview Project 2",
    subProjects: [Project("Some sub project", subProjects: [
        Project(
            "Preview Project",
            subProjects: [Project("Another One", subProjects: [], tasks: [Task("Fix stuff")])],
            tasks: [
                Task("Make tests"),
                Task("Make SwiftData models")
            ]
        )], tasks: [Task("Dimse-dut")])],
    tasks: [
        Task("teste"),
        Task("testeleste")
    ]
)
