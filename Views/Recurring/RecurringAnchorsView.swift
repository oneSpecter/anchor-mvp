//
//  RecurringAnchorsView.swift
//  anchor
//
//  Created by Andrea Blasetti on 22/12/25.
//

import SwiftUI

struct RecurringAnchorsView: View {

    @ObservedObject var vm: RecurringAnchorViewModel
    @State private var showCreate = false

    var body: some View {
        VStack(spacing: 12) {

            ForEach(vm.visibleToday) { anchor in
                RecurringAnchorCardView(anchor: anchor) {
                    vm.completeForToday(anchor.id)
                }
            }

            Spacer()

            Button("Aggiungi anchor") {
                showCreate = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(!vm.canAddMore)
        }
        .padding()
        .navigationTitle("Anchor ricorrenti")
        .sheet(isPresented: $showCreate) {
            NavigationStack {
                CreateRecurringAnchorView(vm: vm)
            }
        }
    }
}

