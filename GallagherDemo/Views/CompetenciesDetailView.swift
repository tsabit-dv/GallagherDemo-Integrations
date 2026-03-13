//
//  CompetenciesDetailView.swift
//  GallagherDemo
//
//  Created by USER on 9/22/1447 AH.
//

import SwiftUI

struct CompetencyDetailView: View {
    @State private var detail: CompetencyDetail?
    let competencyID: String

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let detail = detail {
                    // MARK: - Header Card
                    VStack(alignment: .leading, spacing: 8) {
                        Text(detail.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("ID: \(detail.id)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Division ID: \(detail.division.id)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // MARK: - Info Card
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Notice Period:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(detail.noticePeriod.number) \(detail.noticePeriod.units)")
                        }
                        HStack {
                            Text("Default Expiry:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(detail.defaultExpiry.expiryValue) year(s)")
                        }
                        HStack {
                            Text("Default Access:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(detail.defaultAccess.capitalized)
                        }
                        HStack {
                            Text("Expiry Notify:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(detail.expiryNotify ? "Enabled" : "Disabled")
                        }
                        HStack {
                            Text("Summary Report:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(detail.summaryReportPeriodDays.capitalized)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(12)
                    
                    // MARK: - Messages Card
                    if detail.useDefaultMessages {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Access Messages")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            HStack {
                                Text("Missing Message:")
                                Spacer()
                                Text(detail.messages.missingMessage)
                            }
                            HStack {
                                Text("Expired Message:")
                                Spacer()
                                Text(detail.messages.expiredMessage)
                            }
                            HStack {
                                Text("Expiry Warning:")
                                Spacer()
                                Text(detail.messages.expiryWarningMessage)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                } else {
                    // MARK: - Loading state
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("Loading Competency...")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .navigationTitle("Competency Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            GallagherAPIService.shared.fetchCompetencyDetail(id: competencyID) { fetched in
                self.detail = fetched
            }
        }
    }
}
