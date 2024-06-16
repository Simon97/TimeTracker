//
//  TimeRegistrationView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import SwiftUI

struct TimeRegistrationView: View {
    
    var timeRegistration: TimeRegistration
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(timeRegistration.activity?.name ?? "")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
            
            HStack() {
                VStack(alignment: .leading) {
                    Text("Start time:")
                        .font(.footnote)
                        .bold()
                    Text(timeRegistration.startTime.formatted())
                }
                
                if timeRegistration.endTime != nil {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("End time:")
                            .font(.footnote)
                            .bold()
                        Text((timeRegistration.endTime)!.formatted())
                    }
                }
            }
            Text(timeRegistration.uuid.uuidString)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    TimeRegistrationView(
        timeRegistration: TimeRegistration(
            startTime: .now,
            endTime: .now,
            activity: SampleData.shared.activity
        )
    )
    .padding()
    .border(.black)
}

#Preview("Long name activity") {
    TimeRegistrationView(
        timeRegistration: TimeRegistration(startTime: .now, activity: SampleData.shared.activityWithLongName)
    )
    .padding()
    .border(.black)
}
