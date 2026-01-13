//
//  AnchorCardView.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import SwiftUI

struct AnchorCardView: View {

    let anchor: Anchor
    @ObservedObject var vm: AnchorViewModel

    var body: some View {
        VStack(spacing: 12) {

            Text(anchor.type.rawValue.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(anchor.goal)
                .font(.largeTitle)
                .multilineTextAlignment(.center)

            Text(anchor.text)
                .font(.title3)
                .multilineTextAlignment(.center)

            HStack {
                Button {
                    withAnimation {
                        vm.completeAnchor(anchor.id)
                    }
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                }

                Spacer()

                Button("Next") {
                    // update
                }
                .buttonStyle(.bordered)
            }
        }
        .transition(.move(edge: .leading).combined(with: .opacity))
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

