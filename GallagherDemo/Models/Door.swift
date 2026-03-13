//
//  Door.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import Foundation

struct DoorResponse: Codable {
    let results: [Door]
}

struct Door: Codable, Identifiable {
    let id: String
    let href: String
    let name: String
}
