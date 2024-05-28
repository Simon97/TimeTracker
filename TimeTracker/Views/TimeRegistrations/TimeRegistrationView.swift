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
                .bold()
            HStack() {
                Text(timeRegistration.startTime.formatted())
                if timeRegistration.endTime != nil {
                    Spacer()
                    Text((timeRegistration.endTime)?.formatted() ?? "")
                }
            }
            Text(timeRegistration.uuid.uuidString)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    TimeRegistrationView(
        timeRegistration: TimeRegistration(startTime: .now, activity: SampleData.shared.activity)
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
