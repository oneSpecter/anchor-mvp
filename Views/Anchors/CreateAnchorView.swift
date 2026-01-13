//
//  CreateAnchorView.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//

import SwiftUI

struct CreateAnchorView: View {

    // MARK: - Dependencies
    @ObservedObject var vm: AnchorViewModel
    let category: AnchorCategory
    let mode: CreateAnchorMode

    @Environment(\.dismiss) private var dismiss

    // MARK: - Local state
    @State private var type: AnchorType = .fitness
    @State private var goal: String = ""
    @State private var text: String = ""

    // MARK: - Helpers

    private func trimmed(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: - Computed properties

    /// Serve solo in modalità `.create`
    private var typeIsAvailable: Bool {
        vm.canUseType(type, in: category)
    }
    
    private var availableTypes: [AnchorType] {
        AnchorType.allCases.filter { vm.canUseType($0, in: category) }
    }

    /// Bottone abilitato o no
    private var canSubmit: Bool {
        guard !trimmed(goal).isEmpty else { return false }

        switch mode {
        case .create:
            return typeIsAvailable
        case .queueNext:
            return true
        }
    }

    /// Titolo del bottone
    private var buttonTitle: String {
        switch mode {
        case .create:
            return "Salva"
        case .queueNext:
            return "Next"
        }
    }

    /// Titolo della schermata
    private var screenTitle: String {
        switch mode {
        case .create:
            return "Nuovo anchor"
        case .queueNext:
            return "Prossimo anchor"
        }
    }

    // MARK: - Body

    var body: some View {
        Form {

            // Categoria e tipo SOLO in create
            if case .create = mode {

                Section("Categoria") {
                    Text(category.rawValue)
                }

                Section("Tipologia") {
                    if availableTypes.isEmpty {
                        Text("Hai già usato tutte le tipologie disponibili.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Picker("Tipologia", selection: $type) {
                            ForEach(availableTypes) { t in
                                Text(t.rawValue).tag(t)
                            }
                        }
                        .onAppear {
                            // sicurezza: seleziona il primo disponibile
                            type = availableTypes.first ?? type
                        }
                    }
                }
            }

            Section("Anchor") {
                TextField("Scrivi l'anchor", text: $goal, axis: .vertical)
            }

            Section("Descrizione") {
                TextField("Descrizione", text: $text, axis: .vertical)
            }

            Section {
                Button(buttonTitle) {

                    let success: Bool

                    switch mode {

                    case .create:
                        success = vm.addAnchor(
                            category: category,
                            type: type,
                            goal: trimmed(goal),
                            text: trimmed(text)
                        )

                    case .queueNext(let anchorId):
                        success = vm.queueNextAnchor(
                            for: anchorId,
                            goal: trimmed(goal),
                            text: trimmed(text)
                        )
                    }

                    if success {
                        dismiss()
                    }
                }
                .disabled(!canSubmit)
            }
        }
        .navigationTitle(screenTitle)
    }
}
