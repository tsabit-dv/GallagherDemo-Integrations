//
//  AccessZonesView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

struct AccessZonesView: View {
    @State private var accessZones: [AccessZone] = []

    var body: some View {
        List(accessZones) { zone in
            VStack(alignment: .leading) {
                Text(zone.name)
                    .font(.headline)
                Text("ID: \(zone.id)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(6)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Access Zones")
        .onAppear {
            GallagherAPIService.shared.fetchAccessZones { zones in
                accessZones = zones
            }
        }
    }
}
