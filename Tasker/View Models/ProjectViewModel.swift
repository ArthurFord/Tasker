    //
    //  ProjectViewModel.swift
    //  Tasker
    //
    //  Created by Arthur Ford on 10/26/21.
    //

import Foundation
import Firebase

final class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    @Published var projectTasks: [ProjectTask] = []
    
    let db = Firestore.firestore()
    
    init()  {
        fetchProjects()
        fetchAllProjectTasks()
//        for project in projects {
//            updateProject(project: project)
//            print("init ran")
//        }
    }
        //MARK: - Fetch Projects from Firestore
    func fetchProjects() {
        db.collection("projects").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            self.projects = documents.compactMap({ queryDocumentSnapshot -> Project? in
                return try? queryDocumentSnapshot.data(as: Project.self)
                
            })
        }
    }
    
    func fetchAllProjectTasks() {
        db.collection("tasks").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            self.projectTasks = documents.compactMap({ queryDocumentSnapshot -> ProjectTask? in
                return try? queryDocumentSnapshot.data(as: ProjectTask.self)
                
            })
        }
    }
    
        //MARK: - Get individual project tasks
    func getProjectTasks(forProject project: Project) -> [ProjectTask] {
        var tasks: [ProjectTask] = []
        
        for task in self.projectTasks {
            if task.project == project.id {
                tasks.append(task)
            }
        }
        return tasks
    }
        //MARK: - Add and update projects
    func addProject(_ project: Project) {
        do {
            let _ = try db.collection("projects").addDocument(from: project)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateProject(project: Project) {
        db.collection("projects").document(project.id!).updateData([
            "progress": calcProgress(tasks: getProjectTasks(forProject: project)),
            "progressState": setProgressState(forProject: project, withTasks: getProjectTasks(forProject: project))
            //TODO: - Add logic to update progressState
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                print("updated project")
            }
        }
    }
    
        //MARK: - Add and update tasks
    
    func addProjectTask(_ task: ProjectTask, toProject project: Project) {
        let _ = db.collection("tasks").addDocument(data: [
            "name": task.name,
            "project": project.id!,
            "progress": task.progress,
            "progressState": task.progressState.rawValue,
            "dueDate": task.dueDate
        ])
        updateProject(project: project)
    }
    
    func updateProjectTask(_ task: ProjectTask, inProject project: Project) {
        db.collection("tasks").document(task.id!).updateData([
            "name": task.name,
            "progress": task.progress,
            "progressState": task.progressState.rawValue,
            "dueDate": task.dueDate
        ])
        updateProject(project: project)
    }
    
        //MARK: - Helper functions
    func calcProgress(tasks: [ProjectTask]) -> Int {
        var numberOfTasks = 0
        var completeTasks = 0
        
        for task in tasks {
            numberOfTasks += 1
            if task.progressState == .completed {
                completeTasks += 1
            }
        }
        
        if numberOfTasks > 0 && completeTasks > 0 {
            return Int(Double(completeTasks) / Double(numberOfTasks) * 100)
        } else {
            return 0
        }
    }
    
    func setProgressState(forProject project: Project, withTasks tasks: [ProjectTask]) -> String {
        
        var states: [ProgressState] = []
        
        for task in tasks {
            states.append(task.progressState)
        }
        
        if states.contains(.offTrack) {
            return ProgressState.offTrack.rawValue
        } else if states.contains(.atRisk) {
            return ProgressState.atRisk.rawValue
        } else if states.contains(.onTrack) {
            return ProgressState.onTrack.rawValue
        } else if states.contains(.notStarted) {
            return ProgressState.notStarted.rawValue
        } else {
            return ProgressState.completed.rawValue
        }
        
    }
    
}




