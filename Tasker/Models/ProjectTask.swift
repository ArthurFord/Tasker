//
//  ProjectTask.swift
//  Tasker
//
//  Created by Arthur Ford on 10/26/21.
//

import Foundation
import FirebaseFirestoreSwift

struct ProjectTask: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var project: String = ""
    var name: String = ""
    var dueDate: Date = .now
    var progress: Int = 0
    var progressState: ProgressState
    var assignee: Person?
}

enum ProgressState: String, CaseIterable, Identifiable, Codable, Hashable, Equatable {
    var id: String { self.rawValue }
    
    case notStarted = "Not Started"
    case onTrack = "On Track"
    case atRisk = "At Risk"
    case offTrack = "Off Track"
    case completed = "Completed"
}
