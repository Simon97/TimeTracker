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
        
        var showFavoritesOnly = false
        var showCreateEditView = false
        var newActivity: Activity = Activity("")
             
        /*
        var filteredActivities: [Activity] {
            board.activities.filter { activity in
                (!showFavoritesOnly || activity.isFavorite)
            }
        }
        
        func saveNewActivity() {
            // if we only show favorites, the new activity will automatically be a favorite
            newActivity.isFavorite = showFavoritesOnly
            board.addActivity(newActivity)
            
            // making a new activity ready ...
            newActivity = Activity("")
        }
        
        func deleteActivity(_ activity: Activity) {
            board.removeActivity(activity)
        }
        */
    }
}
