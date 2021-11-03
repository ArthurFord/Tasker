//
//  NewProjectView.swift
//  Tasker
//
//  Created by Arthur Ford on 10/26/21.
//

import SwiftUI

struct NewProjectView: View {
    @StateObject var projectViewModel = ProjectViewModel()
    
    @State var newProject = Project(name: "", startDate: .now, endDate: .now)
    @Binding var isShowing: Bool
    
    var body: some View {
        Form {
            TextField("Project name", text: $newProject.name)
            DatePicker("Start Date", selection: $newProject.startDate, displayedComponents: [.date])
                .datePickerStyle(.compact)
            DatePicker("End Date", selection: $newProject.endDate, displayedComponents: [.date])
            Picker("Status", selection: $newProject.progressState) {
                ForEach(ProgressState.allCases) { status in
                    Text("Status: \(status.rawValue)")
                }
            }
            .pickerStyle(.menu)
            Button {
                projectViewModel.addProject(newProject)
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

//struct NewProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProjectView(newProject: sampleProjects[0], isShowing: .constant(false)))
//    }
//}
