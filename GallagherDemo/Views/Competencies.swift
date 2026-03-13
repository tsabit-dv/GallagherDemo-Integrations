//
//  Competencies.swift
//  GallagherDemo
//
//  Created by USER on 9/22/1447 AH.
//

import SwiftUI

struct CompetenciesView: View {
    @State private var competencies: [Competency] = []
    @State private var isLoading = true
    @State private var selectedCompetencyID: String? = nil

    var body: some View {
        ZStack {
            // MARK: - Main List
            List(competencies) { comp in
                Button(action: {
                    selectedCompetencyID = comp.id
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(comp.name)
                            .font(.headline)
                        Text("ID: \(comp.id)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(6)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Competencies")
            .opacity(isLoading ? 0.3 : 1.0)
            .blur(radius: isLoading ? 3 : 0)

            // MARK: - Loading Overlay
            if isLoading {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Loading Competencies...")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground).opacity(0.7))
            }

            // MARK: - NavigationLink ke Detail
            if let compID = selectedCompetencyID {
                NavigationLink(
                    destination: CompetencyDetailView(competencyID: compID),
                    tag: compID,
                    selection: $selectedCompetencyID
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .onAppear {
            GallagherAPIService.shared.fetchCompetencies { results in
                self.competencies = results
                self.isLoading = false
            }
        }
    }
}
