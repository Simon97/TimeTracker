//
//  ActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct ActivityView: View {
    
    @State private var viewModel: ViewModel
    init(activity: Activity) {
        self.viewModel = ViewModel(activity: activity)
    }
    // @Bindable var activity: Activity
    
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.activity.name)
                Spacer()
                FavoriteButton(isFavourite: $viewModel.activity.isFavorite)
            }
            ForEach(viewModel.activity.timeRegistrations) { reg in
                TimeRegistrationView(timeRegistration: reg)
            }
        }
        .onTapGesture(perform: {
            let newReg = TimeRegistration(
                startTime: .now,
                activity: viewModel.activity
            )
            viewModel.addTimeRegistration(newReg)
        })
    }
}

#Preview {
    ActivityView(activity: Activity("a1", isFavorite: false))
}

extension ActivityView {
    
    @Observable
    class ViewModel {
        var activity: Activity
        
        init(activity: Activity) {
            self.activity = activity
        }
        
        func addTimeRegistration(_ timeRegistration: TimeRegistration) {
            activity.timeRegistrations.append(timeRegistration)
        }
    }
    
}
