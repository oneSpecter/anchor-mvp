//
//  BrainstormItem.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//

import Foundation

struct BrainstormItem: Identifiable, Codable, Hashable {
    let id: UUID
    var text: String
    var createdAt: Date

    init(id: UUID = UUID(), text: String, createdAt: Date = Date()) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
    }
}
