//
//  AnchorType.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import Foundation

enum AnchorType: String, Codable, CaseIterable, Identifiable {
    case fitness = "Fitness"
    case studio = "Studio"
    case lavoro = "Lavoro"
    case benessere = "Benessere"
    case personale = "Personale"

    var id: String { rawValue }
}

