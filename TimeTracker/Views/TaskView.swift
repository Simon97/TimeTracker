//
//  TaskView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var selectedTask: Task
    let task: Task
    
    var body: some View {
        HStack{
            Text(task.name)
            Image(systemName: "star")
                .foregroundStyle(selectedTask === task ? .yellow : .black)
        }
    }
}

#Preview {
    var task = Task("hej")
    return Group {
        // Not the same task
        TaskView(selectedTask: .constant(Task("Some task")), task: Task("Gamer task") )
        
        // Same task
        TaskView(selectedTask: .constant(task), task: task )
    }
}
