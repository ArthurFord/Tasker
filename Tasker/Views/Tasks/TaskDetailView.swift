    //
    //  TaskDetailView.swift
    //  Tasker
    //
    //  Created by Arthur Ford on 10/26/21.
    //

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel
    @State var task: ProjectTask
    @State var project: Project
    @State private var editing: Bool = false
    
    var body: some View {
        if editing {
            Form {
                TextField("Task", text: $task.name)
                DatePicker("Due date", selection: $task.dueDate, displayedComponents: [.date])
                TextField("Progress", value: $task.progress, format: .number)
                Picker("Status", selection: $task.progressState) {
                    ForEach(ProgressState.allCases, id: \.id) { value in
                        Text(value.rawValue)
                            .tag(value)
                    }
                }
                .pickerStyle(.inline)
                Button {
                    projectViewModel.updateProjectTask(task, inProject: project)
                    editing.toggle()
                } label: {
                    VStack(alignment: .center) {
                        Text("Save")
                            .padding(8)
                            .foregroundColor(.white)
                            .frame(width: 100)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity)
                            .font(.title2)
                    }
                }
                
            }
        } else {
            Form {
                Text(task.name)
                Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                Text(task.assignee?.name ?? "Unassigned")
                Text(task.progressState.rawValue)
                Text("\(task.progress)%")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                editing.toggle()
                            } label: {
                                Image(systemName: "pencil.circle")
                            }
                        }
                    }
            }
        }
        
    }
}

    //struct TaskDetailView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        TaskDetailView()
    //    }
    //}
