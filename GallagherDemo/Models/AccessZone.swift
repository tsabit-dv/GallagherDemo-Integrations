//
//  AccessZone.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import Foundation

struct AccessZone: Identifiable, Codable {
    let id: String
    let href: String
    let name: String
}

struct AccessZoneResponse: Codable {
    let results: [AccessZone]
}
