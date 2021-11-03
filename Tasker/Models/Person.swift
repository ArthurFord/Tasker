//
//  Person.swift
//  Tasker
//
//  Created by Arthur Ford on 10/26/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Person: Identifiable, Codable, Hashable  {

    @DocumentID var id: String?
    var name: String
    var projects: [Project]?
    var assignedTasks: [ProjectTask]?
}
