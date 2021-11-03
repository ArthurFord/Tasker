    //
    //  ProjectListView.swift
    //  Tasker
    //
    //  Created by Arthur Ford on 10/26/21.
    //

import SwiftUI

struct ProjectListView: View {
    @StateObject var projectViewModel = ProjectViewModel()
    @State var tasks: [ProjectTask] = []
    @State var showNewProject: Bool = false
    
    var body: some View {
        NavigationView {
            List(projectViewModel.projects) { project in
                
                NavigationLink(destination: {
                    TaskListView(project: project)
                        .environmentObject(projectViewModel)
                }, label: {
                    HStack {
                        ProgressCircle(state: ProgressState(rawValue: project.progressState.rawValue) ?? ProgressState.notStarted, progress: project.progress)
                        VStack(alignment: .leading) {
                            Text(project.name)
                                .font(.headline)
                            Text(project.endDate.formatted(date: .abbreviated, time: .omitted))
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                    }
                })
            }
            .onAppear() {
                for project in projectViewModel.projects {
                    projectViewModel.updateProject(project: project)
                }
            }
            .navigationBarTitle("Projects")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewProject.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showNewProject) {
                        NewProjectView(isShowing: $showNewProject)
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectView(newProject: sampleProjects[0])
//    }
//}

