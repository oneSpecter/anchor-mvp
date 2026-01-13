//
//  RecurringAnchorViewModel.swift
//  anchor
//
//  Created by Andrea Blasetti on 22/12/25.
//

import Foundation
import Combine

@MainActor
final class RecurringAnchorViewModel: ObservableObject {

    @Published private(set) var anchors: [RecurringAnchor] = []

    private let storage: AppStorageService
    private let calendar = Calendar.current

    init(storage: AppStorageService? = nil) {
        let resolvedStorage = storage ?? AppStorageService()
        self.storage = resolvedStorage
        anchors = resolvedStorage.loadRecurringAnchors()
    }

    // MARK: - Public API

    var visibleToday: [RecurringAnchor] {
        anchors.filter { shouldShowToday($0) }
    }

    func add(_ anchor: RecurringAnchor) {
        guard anchors.count < 3 else { return }
        anchors.append(anchor)
        save()
    }

    func completeForToday(_ id: UUID) {
        guard let index = anchors.firstIndex(where: { $0.id == id }) else { return }
        anchors[index].lastCompleted = Date()
        save()
    }

    // MARK: - Logic
    
    var canAddMore: Bool {
        anchors.count < 3
    }

    private func shouldShowToday(_ anchor: RecurringAnchor) -> Bool {
        isScheduledToday(anchor) && !isCompletedToday(anchor)
    }

    private func isCompletedToday(_ anchor: RecurringAnchor) -> Bool {
        guard let last = anchor.lastCompleted else { return false }
        return calendar.isDate(last, inSameDayAs: Date())
    }

    private func isScheduledToday(_ anchor: RecurringAnchor) -> Bool {
        let today = Date()

        switch anchor.recurrence.type {

        case .daily:
            return true

        case .weekly:
            guard let days = anchor.recurrence.daysOfWeek else { return false }
            let weekday = calendar.component(.weekday, from: today)
            return days.contains(weekday)

        case .monthly:
            guard let day = anchor.recurrence.day else { return false }
            return calendar.component(.day, from: today) == day

        case .yearly:
            guard let day = anchor.recurrence.day else { return false }
            let todayDay = calendar.component(.day, from: today)
            let todayMonth = calendar.component(.month, from: today)
            return todayDay == day && todayMonth == 1

        case .custom:
            guard
                let interval = anchor.recurrence.intervalDays,
                let last = anchor.lastCompleted
            else { return true }

            let diff = calendar.dateComponents([.day], from: last, to: today).day ?? 0
            return diff >= interval
        }
    }

    private func save() {
        storage.saveRecurringAnchors(anchors)
    }
}

