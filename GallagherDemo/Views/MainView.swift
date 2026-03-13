//
//  MainView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

struct MainView: View {
    @State private var selectedModel: APITarget = .cardholders
    @State private var showSidebar = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            // MARK: - Layer 1: Konten Utama
            NavigationView {
                VStack(spacing: 0) {
                    // Custom Navigation Bar
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                showSidebar.toggle()
                            }
                        }) {
                            Image(systemName: "text.justify") // Ikon hamburger yang lebih modern
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                        Text(selectedModel.rawValue)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(.systemBackground))
                    .overlay(
                        Divider(), alignment: .bottom
                    )
                    
                    // Konten Dinamis
                    Group {
                        switch selectedModel {
                        case .cardholders:
                            CardholdersView()

                        case .doors:
                            DoorsView()

                        case .events:
                            EventsView()

                        case .accessZones:
                            AccessZonesView()

                        case .competencies:
                            CompetenciesView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .navigationBarHidden(true)
                .ignoresSafeArea(.keyboard)
            }
            
            // MARK: - Layer 2: Latar Belakang Gelap (Overlay)
            if showSidebar {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showSidebar = false
                        }
                    }
                    // Efek fade in
                    .transition(.opacity)
            }
            
            // MARK: - Layer 3: Sidebar
            if showSidebar {
                SidebarView(selectedModel: $selectedModel, showSidebar: $showSidebar)
                    .transition(.move(edge: .leading))
            }
        }
        .statusBar(hidden: false) // Pastikan status bar terlihat
    }
}
