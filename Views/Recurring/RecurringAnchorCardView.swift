//
//  RecurringAnchorCardView.swift
//  anchor
//
//  Created by Andrea Blasetti on 22/12/25.
//


import SwiftUI

struct RecurringAnchorCardView: View {

    let anchor: RecurringAnchor
    let onComplete: () -> Void

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    onComplete()
                }
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(anchor.title)
                    .font(.headline)

                Text(anchor.time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(14)
        .transition(.move(edge: .leading).combined(with: .opacity))
    }
}
