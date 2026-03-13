//
//  Event.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import Foundation

struct EventResponse: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {

    let id: String
    let href: String
    let message: String
    let time: String
    let priority: Int

    let source: EventSource?
    let type: EventType?
    let group: EventGroup?
    let division: EventDivision?
}

struct EventSource: Codable {
    let id: String
    let name: String
}

struct EventType: Codable {
    let id: String
    let name: String
}

struct EventGroup: Codable {
    let id: String
    let name: String
}

struct EventDivision: Codable {
    let id: String
    let name: String
}
