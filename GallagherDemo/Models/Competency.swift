//
//  Competency.swift
//  GallagherDemo
//
//  Created by USER on 9/22/1447 AH.
//

import Foundation

struct CompetencyResponse: Codable {
    let results: [Competency]
}

struct Competency: Codable, Identifiable {
    let id: String
    let href: String
    let name: String
}

struct CompetencyDetail: Codable {

    let id: String
    let href: String
    let name: String
    let division: Division
    let noticePeriod: NoticePeriod
    let defaultExpiry: DefaultExpiry
    let defaultAccess: String
    let useDefaultMessages: Bool
    let messages: Messages
    let expiryNotify: Bool
    let summaryReportPeriodDays: String
}

struct Division: Codable {
    let id: String
    let href: String
}

struct NoticePeriod: Codable {
    let units: String
    let number: Int
}

struct DefaultExpiry: Codable {
    let expiryType: String
    let expiryValue: Int
}

struct Messages: Codable {
    let missingMessage: String
    let expiredMessage: String
    let expiryWarningMessage: String
}
