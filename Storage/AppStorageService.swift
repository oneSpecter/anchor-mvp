//
//  AppStorageService.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//

import Foundation

final class AppStorageService {

    private let anchorsURL: URL
    private let brainstormURL: URL
    private let recurringAnchorsURL: URL

    init() {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        anchorsURL = dir.appendingPathComponent("anchors.json")
        brainstormURL = dir.appendingPathComponent("brainstorm.json")
        recurringAnchorsURL = dir.appendingPathComponent("recurring_anchors.json")
    }

    // MARK: - Anchors

    func loadAnchors() -> [Anchor] {
        do {
            let data = try Data(contentsOf: anchorsURL)
            return try JSONDecoder().decode([Anchor].self, from: data)
        } catch {
            return []
        }
    }

    func saveAnchors(_ anchors: [Anchor]) {
        do {
            let data = try JSONEncoder().encode(anchors)
            try data.write(to: anchorsURL, options: .atomic)
        } catch {
            print("Save anchors error:", error)
        }
    }
    
    // MARK: - Recurring Anchors

      /* func loadRecurringAnchors() -> [RecurringAnchor] {
          do {
              let data = try Data(contentsOf: recurringAnchorsURL)
              return try JSONDecoder().decode([RecurringAnchor].self, from: data)
          } catch {
              return []
          }
      } */
    
    func loadRecurringAnchors() -> [RecurringAnchor] {
        [
            RecurringAnchor(
                title: "Allenamento",
                time: "17:00",
                recurrence: RecurrenceRule(
                    type: .weekly,
                    daysOfWeek: [2, 4, 6]
                )
            ),
            RecurringAnchor(
                title: "Studio profondo",
                time: "21:00",
                recurrence: RecurrenceRule(type: .daily)
            )
        ]
    }

      func saveRecurringAnchors(_ anchors: [RecurringAnchor]) {
          do {
              let data = try JSONEncoder().encode(anchors)
              try data.write(to: recurringAnchorsURL, options: .atomic)
          } catch {
              print("Save recurring anchors error:", error)
          }
      }

    // MARK: - Brainstorm

    func loadBrainstorm() -> [BrainstormItem] {
        do {
            let data = try Data(contentsOf: brainstormURL)
            return try JSONDecoder().decode([BrainstormItem].self, from: data)
        } catch {
            return []
        }
    }

    func saveBrainstorm(_ items: [BrainstormItem]) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: brainstormURL, options: .atomic)
        } catch {
            print("Save brainstorm error:", error)
        }
    }
}

