//
//  APITarget.swift
//  GallagherDemo
//
//  Created by USER on 9/22/1447 AH.
//

import Foundation

enum APITarget: String, CaseIterable, Identifiable {
    
    case cardholders = "Cardholders"
    case doors = "Doors"
    case events = "Events"
    case accessZones = "Access Zones"
    case competencies = "Competencies"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .cardholders:
            return "person.2.fill"
        case .doors:
            return "door.left.hand.open"
        case .events:
            return "clock.arrow.circlepath"
        case .accessZones:
            return "shield.lefthalf.fill"
        case .competencies:
            return "checkmark.seal.fill"
        }
    }
}
