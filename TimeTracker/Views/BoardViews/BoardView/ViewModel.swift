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
        var showFavoritesOnly = false
        var showCreateEditView = false
        var newActivity: Activity = Activity("", isFavorite: false)
        
        init(board: Board) {
            self.board = board
        }
        
        var filteredActivities: [Activity] {
            board.activities.filter { activity in
                (!showFavoritesOnly || activity.isFavorite)
            }
        }
        
        func saveNewTask() {
            // if we only show favorites, the new activity will automatically be a favorite
            newActivity.isFavorite = showFavoritesOnly
            board.activities.append(newActivity)
            
            // making a new activity ready ...
            newActivity = Activity("", isFavorite: false)
        }
    }
}
