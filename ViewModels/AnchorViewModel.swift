//
//  AnchorViewModel.swift
//  anchor
//
//  Created by Andrea Blasetti on 20/12/25.
//
import Foundation
import Combine

@MainActor
final class AnchorViewModel: ObservableObject {

    // MARK: - State

    @Published private(set) var anchors: [Anchor] = []
    @Published var editingAnchor: Anchor? = nil

    private let storage: AppStorageService

    // MARK: - Init (dependency injection)
    init(storage: AppStorageService? = nil) {
        let resolvedStorage = storage ?? AppStorageService()
        self.storage = resolvedStorage
        anchors = resolvedStorage.loadAnchors()
    }

    // MARK: - Query helpers

    func activeAnchors(in category: AnchorCategory) -> [Anchor] {
        anchors.filter { $0.category == category && $0.status == .active }
    }

    func activeAnchor(for type: AnchorType, in category: AnchorCategory) -> Anchor? {
        anchors.first {
            $0.type == type &&
            $0.category == category &&
            $0.status == .active
        }
    }

    func anchor(by id: UUID) -> Anchor? {
        anchors.first { $0.id == id }
    }

    // MARK: - Rules

    func canOpenAddAnchor(category: AnchorCategory) -> Bool {
        activeAnchors(in: category).count < 3
    }

    func canUseType(_ type: AnchorType, in category: AnchorCategory) -> Bool {
        activeAnchor(for: type, in: category) == nil
    }

    // MARK: - Actions

    @discardableResult
    func addAnchor(category: AnchorCategory, type: AnchorType, goal: String, text: String) -> Bool {

        let goal = goal.trimmingCharacters(in: .whitespacesAndNewlines)
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !goal.isEmpty else { return false }

        guard canOpenAddAnchor(category: category) else { return false }
        guard canUseType(type, in: category) else { return false }

        let newAnchor = Anchor(
            category: category,
            type: type,
            goal: goal,
            text: text,
            status: .active
        )

        anchors.append(newAnchor)
        persist()
        return true
    }

    func queueNextAnchor(for anchorId: UUID, goal:String, text: String) -> Bool {
        
        let goal = goal.trimmingCharacters(in: .whitespacesAndNewlines)
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !goal.isEmpty else { return false }
        guard let idx = anchors.firstIndex(where: { $0.id == anchorId }) else { return false }

        let next = Anchor(
            category: anchors[idx].category,
            type: anchors[idx].type,
            goal: goal,
            text: text,
            status: .queued
        )

        anchors.append(next)
        anchors[idx].nextAnchorId = next.id
        persist()
        return true
    }

    func completeAnchor(_ anchorId: UUID) {
        guard let idx = anchors.firstIndex(where: { $0.id == anchorId }) else { return }

        anchors[idx].status = .completed
        anchors[idx].completedAt = Date()

        if let nextId = anchors[idx].nextAnchorId,
           let nextIndex = anchors.firstIndex(where: { $0.id == nextId }) {
            anchors[nextIndex].status = .active
        }

        persist()
    }

    // MARK: - Editing

    func startEditing(_ anchor: Anchor) {
        editingAnchor = anchor
    }

    func saveEdit(anchorId: UUID, newText: String) {
        let clean = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return }
        guard let idx = anchors.firstIndex(where: { $0.id == anchorId }) else { return }

        anchors[idx].text = clean
        persist()
        editingAnchor = nil
    }

    // MARK: - Persistence

    private func persist() {
        storage.saveAnchors(anchors)
    }
}
