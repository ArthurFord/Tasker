    //
    //  TaskListView.swift
    //  Tasker
    //
    //  Created by Arthur Ford on 10/26/21.
    //

import SwiftUI

struct TaskListView: View {
    var project: Project
    @State var isShowingModal: Bool = false
    var tasks: [ProjectTask] {
        return projectViewModel.getProjectTasks(forProject: project)
    }
    
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    var body: some View {
        
        List(tasks) { task in
            NavigationLink {
                TaskDetailView(task: task, project: project)
                    .environmentObject(projectViewModel)
            } label: {
                TaskListCellView(task: task)
            }
        }
        .onAppear(perform: {
            //tasks = projectViewModel.getProjectTasks(forProject: project)
        })
        .navigationBarTitle(project.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingModal.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowingModal) {
                    NewTaskView(project: project, isShowing: $isShowingModal)
                        
                }
                
            }
            
        }
    }
}

//struct TaskListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView()
//    }
//}
