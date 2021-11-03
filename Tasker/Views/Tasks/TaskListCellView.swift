//
//  TaskListCellView.swift
//  Tasker
//
//  Created by Arthur Ford on 11/3/21.
//

import SwiftUI

struct TaskListCellView: View {
    
    var task: ProjectTask
    var body: some View {
        HStack {
            ProgressCircle(state: task.progressState, progress: task.progress)
            VStack(alignment: .leading) {
                Text(task.name)
                Spacer()
                Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(5)
                Spacer()
                Text(task.assignee?.name ?? "Not Assigned")
                    .font(.footnote)
                    .fontWeight(.light)
            }
            Spacer()
        }
        .padding(.vertical)
        .frame(height: 84)
    }
}
