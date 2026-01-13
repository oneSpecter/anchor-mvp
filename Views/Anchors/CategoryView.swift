//
//  CategoryView.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//

import SwiftUI

import SwiftUI

struct CategoryView: View {

    let category: AnchorCategory
    @ObservedObject var vm: AnchorViewModel

    @State private var showCreate = false

    var body: some View {
        VStack(spacing: 24) {

            // Titolo
            Text(category.rawValue)
                .font(.title2)
                .bold()

            let activeAnchors = vm.activeAnchors(in: category)

            if activeAnchors.isEmpty {
                Text("Nessun anchor attivo")
                    .foregroundColor(.secondary)
            } else {
                ForEach(activeAnchors.prefix(3)) { anchor in
                    AnchorCardView(anchor: anchor, vm: vm)
                }

                if activeAnchors.count > 3 {
                    Text("+ altri \(activeAnchors.count - 3)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Button("Aggiungi anchor") {
                showCreate = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(!vm.canOpenAddAnchor(category: category))
        }
        .padding()
        .navigationTitle(category.rawValue)
        .sheet(isPresented: $showCreate) {
            NavigationStack {
                CreateAnchorView(
                    vm: vm,
                    category: category,
                    mode: .create
                )
            }
        }
    }
}

