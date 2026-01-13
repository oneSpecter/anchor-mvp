//
//  CreateRecurringAnchorView.swift
//  anchor
//
//  Created by Andrea Blasetti on 23/12/25.
//

import SwiftUI

struct CreateRecurringAnchorView: View {

    @ObservedObject var vm: RecurringAnchorViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var time = Date()

    @State private var recurrenceType: RecurrenceType = .daily
    @State private var recurrence: RecurrenceRule = .daily()

    var body: some View {
        Form {

            // MARK: - Anchor
            Section("Anchor") {
                TextField("Nome", text: $title)
            }

            // MARK: - Orario
            Section("Orario") {
                DatePicker(
                    "Ora",
                    selection: $time,
                    displayedComponents: .hourAndMinute
                )
            }

            // MARK: - Ricorrenza
            Section("Ricorrenza") {

                Picker("Tipo", selection: $recurrenceType) {
                    ForEach(RecurrenceType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                            .tag(type)
                    }
                }

                // Placeholder semplice per ora
                recurrenceDetailsView
            }

            // MARK: - Salva
            Button("Salva") {
                vm.add(
                    RecurringAnchor(
                        title: title,
                        time: formattedTime,
                        recurrence: recurrence
                    )
                )
                dismiss()
            }
            .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .navigationTitle("Nuovo anchor")
        .onChange(of: recurrenceType) { _ in
            updateRecurrence()
        }
    }

    // MARK: - Recurrence helpers

    private func updateRecurrence() {
        switch recurrenceType {

        case .daily:
            recurrence = .daily()

        case .weekly:
            // placeholder → lun, mer, ven
            recurrence = .weekly(days: [2, 4, 6])

        case .monthly:
            recurrence = .monthly(day: 1)

        case .yearly:
            recurrence = .yearly(day: 1)

        case .custom:
            recurrence = .custom(every: 1)
        }
    }

    @ViewBuilder
    private var recurrenceDetailsView: some View {
        switch recurrenceType {

        case .daily:
            Text("Ogni giorno")
                .font(.caption)
                .foregroundColor(.secondary)

        case .weekly:
            Text("Giorni: Lun, Mer, Ven")
                .font(.caption)
                .foregroundColor(.secondary)

        case .monthly:
            Text("Ogni mese (giorno 1)")
                .font(.caption)
                .foregroundColor(.secondary)

        case .yearly:
            Text("Ogni anno (1 gennaio)")
                .font(.caption)
                .foregroundColor(.secondary)

        case .custom:
            Text("Ogni 1 giorno")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    // MARK: - Formatting

    private var formattedTime: String {
        let f = DateFormatter()
        f.timeStyle = .short
        return f.string(from: time)
    }
}
