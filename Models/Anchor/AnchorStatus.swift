//
//  AnchorStatus.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import Foundation

enum AnchorStatus: String, Codable {
    case active
    case completed
    case queued   // “next anchor” non ancora attivo
}

