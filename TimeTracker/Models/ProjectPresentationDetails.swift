//
//  ProjectPresentationDetails.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 08/02/2024.
//

import Foundation
import SwiftData

/**
 This model describes how a project should be presented.
 It is used to persists if the corresponding project-row previously was collapsed or not
 */

@Model
class ProjectPresentationDetails {
    var isCollapsed: Bool
    var project: ProjectWithTasks?
    
    init(isCollapsed: Bool) {
        self.isCollapsed = isCollapsed
    }
}
