//
//  Project.swift
//  Tasker
//
//  Created by Arthur Ford on 10/26/21.
//

import Foundation
import FirebaseFirestoreSwift

class Project: Identifiable, Codable, Hashable, ObservableObject {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @DocumentID var id: String?
    
    var name: String
    var startDate: Date
    var endDate: Date
    var progress: Int = 0
    var progressState = ProgressState.notStarted
    
    init(name: String, startDate: Date, endDate: Date) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.progress = 0
        self.progressState = ProgressState.notStarted
    }
    
}
