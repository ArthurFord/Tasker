//
//  TaskerApp.swift
//  Tasker
//
//  Created by Arthur Ford on 10/26/21.
//

import SwiftUI
import Firebase

@main
struct TaskerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                ProjectListView()
        }
    }
}

