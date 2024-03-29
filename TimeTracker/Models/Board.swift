//
//  Board.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import Foundation
import Observation
import SwiftData

@Observable
class Board {
    var activities: [Activity]
    
    init(activities: [Activity]) {
        self.activities = activities
    }
}
