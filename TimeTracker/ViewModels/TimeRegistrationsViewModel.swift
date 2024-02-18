//
//  TimeRegistrations.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import Foundation
import SwiftData

/**
 The idea is to a small degree that this https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project
 refers to as a ViewModel. However, since multiple views/child-views are going to use it, I am not sure if it good to place it as an extension
 to (for example) the BottomInfoView
 */

class TimeRegistrationsViewModel {
    
    var registrations: [TimeRegistration]
    
    let controller = TimeRegistrationController()
    
    init(registrations: [TimeRegistration]) {
        self.registrations = registrations
    }
    
    var currentTask: Task? {
        controller.currentTask(&registrations)
    }
    
    var currentTimeRegistration: TimeRegistration? {
        controller.currentTimeRegistration(&registrations)
    }
    
    var timeSpendOnTaskToday: TimeInterval {
        if let currentTask = currentTask {
            return controller.timeSpendOnTaskonDate(registrations, task: currentTask, date: .now)
        }
        return 0.0
    }
    
    func isCurrentTask(task: Task) -> Bool? {
        return currentTask == task
    }
    
    func sort() {
        controller.sortByDate(&registrations)
    }
    
    func appendRegistration(_ registration: TimeRegistration) {
        currentTask?.timeRegistrations.append(registration)
        
        // TODO: What if there is no previous registration?
        // This only works because this function is not used to begin with
        // We can make this register the first one as well by looking at the
        // task in the registration we try to append ...
        
        controller.sortByDate(&registrations)
    }
}
