//
//  BrainstormView.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//

import SwiftUI

struct BrainstormView: View {

    @ObservedObject var vm: BrainstormViewModel

    @State private var text: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                Text("Brainstorm")
                    .font(.title2)
                    .bold()

                TextField("Nuova idea", text: $text)
                    .focused($isFocused)
                    .textFieldStyle(.roundedBorder)

                Button("Aggiungi") {
                    vm.add(text)
                    text = ""
                    isFocused = false
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )

                List {
                    ForEach(vm.items) { item in
                        Text(item.text)
                            .swipeActions(edge: .leading) {
                                Button(role: .destructive) {
                                    vm.delete(item)
                                } label: {
                                    Label("Elimina", systemImage: "trash")
                                }
                            }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .padding()
            .navigationTitle("Brainstorm")
        }
    }
}

