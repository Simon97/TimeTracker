//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftData
import SwiftUI

enum Tab {
    case favorites
    case activities
    case timeRegistrations
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var selection: Tab = .activities
    
    @Query private var boards: [Board]
    
    var timeRegistrations: ObservedTimeRegistrations
    
    init(boards: [Board], timeRegistrations: [TimeRegistration]) {
        var regs: [TimeRegistration] = []
        for activity in boards[0].activities {
            for registration in activity.timeRegistrations {
                regs.append(registration)
            }
        }
        
        self.timeRegistrations = ObservedTimeRegistrations(timeRegistrations: regs)
    }
    
    /*
     @Query private var boards: [Board]
     private var timeRegistrations: [TimeRegistration] {
     var regs: [TimeRegistration] = []
     
     for activity in boards[0].activities {
     for registration in activity.timeRegistrations {
     regs.append(registration)
     }
     }
     return regs
     }
     */
    
    // @Query private var timeRegistrations: [TimeRegistration]
    
    /*
     private var timeRegistrationViewModel: TimeRegistrationsViewModel {
     // Maybe do some sorting first ...
     return TimeRegistrationsViewModel(registrations: timeRegistrations)
     }
     */
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ActivitiesTabView(board: boards[0])
                TimeRegistrationsTab(
                    timeRegistrations: timeRegistrations
                )
            }
            .background(.black)
            
            TrackingControllerView(
                timeRegistrations: timeRegistrations
            )
        }
    }
}

/*
 #Preview {
 ContentView()
 }
 */

/*
extension ContentView {
    
    class ViewModel {
        
        var boards: [Board]
        var timeRegistrations: ObservedTimeRegistrations
        
        init(boards: [Board]) {
            self.boards = boards
            
            // TODO: This should be fixed as soon as we have more than a single board
            var regs: [TimeRegistration] = []
            for activity in boards[0].activities {
                for registration in activity.timeRegistrations {
                    regs.append(registration)
                }
            }
            self.timeRegistrations = ObservedTimeRegistrations(
                timeRegistrations: regs
            )
        }
    }
}
*/
