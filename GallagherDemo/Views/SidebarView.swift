//
//  SidebarView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

struct SidebarView: View {
    
    @Binding var selectedModel: APITarget
    @Binding var showSidebar: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - Header Profil
                HStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Gallagher Demo")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Access Control")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 50) // Offset untuk Safe Area
                .padding(.bottom, 24)
                .padding(.horizontal, 20)
                
                Divider()
                    .padding(.horizontal, 20)
                
                // MARK: - Menu List
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("MENU")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        ForEach(APITarget.allCases) { target in
                            MenuRowView(
                                target: target,
                                isSelected: selectedModel == target
                            ) {
                                selectedModel = target
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    showSidebar = false
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                // MARK: - Footer / Version
                VStack {
                    Divider()
                    Text("Version 1.0.0")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 20)
            }
            .frame(width: 280) // Lebar sidebar standar modern
            .background(
                // Background yang adaptif (Putih di Light Mode, Hitam di Dark Mode)
                Color(.systemBackground)
                    .ignoresSafeArea()
            )
            
            Spacer() // Mendorong sidebar ke kiri
        }
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 0)
    }
}

// MARK: - Subview untuk Baris Menu (Lebih Rapi)
struct MenuRowView: View {
    let target: APITarget
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: target.icon)
                    .font(.title3)
                    .frame(width: 24)
                
                Text(target.rawValue)
                    .font(.body)
                    .fontWeight(isSelected ? .semibold : .regular)
                
                Spacer()
                
                // Indikator panah atau centang opsional
                if isSelected {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.blue : Color.clear)
            )
            .contentShape(Rectangle()) // Agar area kosong bisa diklik
        }
        .padding(.horizontal, 12)
        .buttonStyle(PlainButtonStyle())
    }
}
