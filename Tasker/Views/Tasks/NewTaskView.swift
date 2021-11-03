//
//  NewTaskView.swift
//  Tasker
//
//  Created by Arthur Ford on 10/27/21.
//

import SwiftUI

struct NewTaskView: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    var project: Project
    @State var newTask = ProjectTask(name: "", dueDate: .now, progressState: ProgressState.notStarted)
    @Binding var isShowing: Bool
    
    
    var body: some View {
        Form {
            TextField("Task name", text: $newTask.name)
            DatePicker("Due Date", selection: $newTask.dueDate, displayedComponents: [.date])
                .datePickerStyle(.compact)
            Picker("Status", selection: $newTask.progressState) {
                ForEach(ProgressState.allCases) { status in
                    Text("Status: \(status.rawValue)")
                }
            }
            .pickerStyle(.menu)
            Picker("Assignee", selection: $newTask.assignee) {
                ForEach(samplePeople) { person in
                    Text(person.name)
                }
            }
            Button {
                projectViewModel.addProjectTask(newTask, toProject: project)
                projectViewModel.updateProject(project: project)
                isShowing.toggle()
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
    }
}

//struct NewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskView(newTask: sampleProjects[0].tasks[0], isShowing: .constant(false))
//    }
//}
