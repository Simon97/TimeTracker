//
//  ActivitiesViewModel.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 30/03/2024.
//

import Foundation

@Observable
class ActivitiesViewModel {
    var activities: [Activity]
    
    init(activities: [Activity]) {
        self.activities = activities
    }
}
