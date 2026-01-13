//
//  Anchor.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import Foundation

struct Anchor: Identifiable, Codable, Hashable {
    let id: UUID
    var category: AnchorCategory
    var type: AnchorType
    var goal: String // il goal dell'anchor
    var text: String // descrione dell'anchor
    var status: AnchorStatus

    // Progressione: se completo questo, attivo questo anchor successivo
    var nextAnchorId: UUID?

    var createdAt: Date
    var completedAt: Date?

    init(
        id: UUID = UUID(),
        category: AnchorCategory,
        type: AnchorType,
        goal: String,
        text: String,
        status: AnchorStatus = .active,
        nextAnchorId: UUID? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil
    ) {
        self.id = id
        self.category = category
        self.type = type
        self.goal = goal
        self.text = text
        self.status = status
        self.nextAnchorId = nextAnchorId
        self.createdAt = createdAt
        self.completedAt = completedAt
    }
}

