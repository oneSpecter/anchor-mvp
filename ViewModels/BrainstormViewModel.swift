//
//  BrainstormViewModel.swift
//  anchor
//
//  Created by Andrea Blasetti on 20/12/25.
//

import Foundation
import Combine

@MainActor
final class BrainstormViewModel: ObservableObject {
    
    @Published private(set) var items: [BrainstormItem] = []

    private let storage: AppStorageService

    init(storage: AppStorageService? = nil) {
        let resolvedStorage = storage ?? AppStorageService()
        self.storage = resolvedStorage
        items = resolvedStorage.loadBrainstorm()
    }

    func add(_ text: String) {
        let clean = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return }

        items.insert(BrainstormItem(text: clean), at: 0)
        storage.saveBrainstorm(items)
    }
    
    func clearAll() {
        items.removeAll()
        storage.saveBrainstorm(items)
    }

    func delete(_ item: BrainstormItem) {
        items.removeAll { $0.id == item.id }
        storage.saveBrainstorm(items)
    }
}
