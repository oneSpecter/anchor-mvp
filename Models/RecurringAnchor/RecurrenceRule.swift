//
//  RecurrenceRule.swift
//  anchor
//
//  Created by Andrea Blasetti on 22/12/25.
//

struct RecurrenceRule: Codable {

    let type: RecurrenceType
    var daysOfWeek: [Int]?
    var day: Int?
    var intervalDays: Int?

    // MARK: - Factory init

    static func daily() -> RecurrenceRule {
        RecurrenceRule(type: .daily)
    }

    static func weekly(days: [Int]) -> RecurrenceRule {
        RecurrenceRule(type: .weekly, daysOfWeek: days)
    }

    static func monthly(day: Int) -> RecurrenceRule {
        RecurrenceRule(type: .monthly, day: day)
    }

    static func yearly(day: Int) -> RecurrenceRule {
        RecurrenceRule(type: .yearly, day: day)
    }

    static func custom(every days: Int) -> RecurrenceRule {
        RecurrenceRule(type: .custom, intervalDays: days)
    }
}

