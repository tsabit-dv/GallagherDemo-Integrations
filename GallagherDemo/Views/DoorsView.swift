//
//  DoorsView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

struct DoorsView: View {
    
    @State private var doors: [Door] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            
            List(doors) { door in
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(door.name)
                        .font(.headline)
                    
                    Text("ID: \(door.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
            }
            .listStyle(.insetGrouped)
        }
        .onAppear {
            GallagherAPIService.shared.fetchDoors { result in
                doors = result
            }
        }
    }
}
