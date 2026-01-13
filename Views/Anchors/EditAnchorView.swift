//
//  EditAnchorView.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import SwiftUI

struct EditAnchorView: View {

    @ObservedObject var vm: AnchorViewModel
    let anchorId: UUID

    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""

    var body: some View {
        Form {
            Section("Testo") {
                TextField("Modifica anchor", text: $text, axis: .vertical)
            }

            Button("Salva modifiche") {
                vm.saveEdit(anchorId: anchorId, newText: text)
                dismiss()
            }
        }
        .navigationTitle("Modifica")
        .onAppear {
            if let anchor = vm.anchors.first(where: { $0.id == anchorId }) {
                text = anchor.text
            }
        }
    }
}

