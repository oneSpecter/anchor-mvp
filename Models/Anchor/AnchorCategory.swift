//
//  AnchorCategory.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import Foundation

enum AnchorCategory: String, Codable, CaseIterable, Identifiable {
    case daily = "Giornalieri"
    case weekly = "Settimanali"
    case monthly = "Mensili"
    case yearly = "Annuali"

    var id: String { rawValue }
}

