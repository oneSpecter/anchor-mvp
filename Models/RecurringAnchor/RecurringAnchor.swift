//
//  RecurringAnchor.swift
//  anchor
//
//  Created by Andrea Blasetti on 22/12/25.
//

import Foundation

struct RecurringAnchor: Identifiable, Codable {
    let id: UUID
    var title: String
    var time: String           // "17:00"
    var recurrence: RecurrenceRule
    var lastCompleted: Date?
    var active: Bool

    init(
        id: UUID = UUID(),
        title: String,
        time: String,
        recurrence: RecurrenceRule,
        lastCompleted: Date? = nil,
        active: Bool = true
    ) {
        self.id = id
        self.title = title
        self.time = time
        self.recurrence = recurrence
        self.lastCompleted = lastCompleted
        self.active = active
    }
}
