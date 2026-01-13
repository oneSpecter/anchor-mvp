//
//  RootView.swift
//  anchor
//
//  Created by Andrea Blasetti on 19/12/25.
//


import SwiftUI

struct RootView: View {

    @StateObject private var vm = AnchorViewModel()
    @StateObject private var rvm = RecurringAnchorViewModel()
    @StateObject private var bvm = BrainstormViewModel()

    var body: some View {
        TabView {

            CategoryView(category: .daily, vm: vm)
                .tabItem {
                    Label("Giorno", systemImage: "sun.max")
                }

            CategoryView(category: .weekly, vm: vm)
                .tabItem {
                    Label("Settimana", systemImage: "calendar")
                }

            CategoryView(category: .monthly, vm: vm)
                .tabItem {
                    Label("Mese", systemImage: "calendar.circle")
                }

            CategoryView(category: .yearly, vm: vm)
                .tabItem {
                    Label("Anno", systemImage: "calendar.badge.clock")
                }

            BrainstormView(vm: bvm)
                .tabItem {
                    Label("Brainstorm", systemImage: "lightbulb")
                }
            
            RecurringAnchorsView(vm: rvm)
                .tabItem {
                    Label("Recurrency", systemImage: "moon")
                }
        }
    }
}

