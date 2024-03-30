//
//  ActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct ActivityView: View {
    
    @Bindable var activity: Activity
    
    var body: some View {
        HStack{
            Text(activity.name)
            Spacer()
            FavoriteButton(isFavourite: $activity.isFavorite)
        }
    }
}

#Preview {
    ActivityView(activity: Activity("a1", isFavorite: false))
}
