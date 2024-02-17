//
//  TimeRegistrations.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import Foundation
import SwiftData

/**
 The idea is to a small degree that this is what https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project
 refers to as a ViewModel. However, since multiple views/child-views are going to use it, I am not sure if it good to place it as an extension
 to (for example) the BottomInfoView
 */

@Observable
class TimeRegistrationViewModel {
    let controller = TimeRegistrationController()
    var registrations: [TimeRegistration]
    
    init(registrations: [TimeRegistration]) {
        self.registrations = registrations
    }
    
    func sort() {
        controller.sortByDate(&registrations)
    }
}
