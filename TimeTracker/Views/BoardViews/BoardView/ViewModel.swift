//
//  ViewModel.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 02/04/2024.
//

import Foundation
import Observation

extension BoardView {
    
    @Observable
    class ViewModel {
        
        var board: Board
        var timeRegistrations: ObservedTimeRegistrations
        
        var showFavoritesOnly = false
        var showCreateEditView = false
        var newActivity: Activity = Activity("", isFavorite: false)
        
        init(board: Board, timeRegistrations: ObservedTimeRegistrations) {
            self.board = board
            self.timeRegistrations = timeRegistrations
            
            
        }
        
        var filteredActivities: [Activity] {
            board.activities.filter { activity in
                (!showFavoritesOnly || activity.isFavorite)
            }
        }
        
        func saveNewActivity() {
            // if we only show favorites, the new activity will automatically be a favorite
            newActivity.isFavorite = showFavoritesOnly
            board.activities.append(newActivity)
            
            // making a new activity ready ...
            newActivity = Activity("", isFavorite: false)
        }
        
        func deleteActivity(with id: UUID) {
            board.activities.removeAll(where: { activity in
                activity.uuid == id
            })
        }
        
    }
}
