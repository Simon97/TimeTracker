//
//  GlobalAppData.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import Foundation

/**
 Not sure if this is the best approach or if it for example is better to have all data as single attributes in the
 app struct
 */

@Observable
class GlobalAppData {
    var currentProject: Project = Project("Empty")
}
