//
//  Cardholder.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import Foundation

struct CardholderResponse: Codable {
    let results: [Cardholder]
}

struct Cardholder: Codable, Identifiable {

    let id: String
    let firstName: String?
    let lastName: String?

    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
}

struct CardholderDetail: Codable {

    let id: String
    let firstName: String?
    let lastName: String?
    let authorised: Bool?

    let cards: [Card]?
    let competencies: [CompetencyStatus]?

    let address: String?
    let email: String?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case authorised
        case cards
        case competencies
        case address = "@Address"
        case email = "@Email"
        case phone = "@Phone"
    }
}

struct Card: Codable, Identifiable {

    let id = UUID()

    let number: String
    let credentialClass: String?

    let status: CardStatus?
}

struct CardStatus: Codable {
    let value: String
}

struct CompetencyStatus: Codable, Identifiable {

    let id = UUID()

    let competency: CompetencyName
    let expiry: String?
}

struct CompetencyName: Codable {
    let name: String
}
