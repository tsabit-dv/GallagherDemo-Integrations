//
//  GallagherAPIService.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.

import Foundation

class GallagherAPIService {

    static let shared = GallagherAPIService()

    private let baseURL = "https://<URL>:8904/api"
    private let apiKey = "API-KEY"

    // MARK: - Shared URLSession with SSL Bypass
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config,
                          delegate: SSLBypassDelegate(),
                          delegateQueue: nil)
    }()

    // MARK: - Test Connection
    func testConnection() {

        guard let url = URL(string: "\(baseURL)/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, response, error in

            if let error = error {
                print("❌ ERROR:", error)
                return
            }

            if let response = response as? HTTPURLResponse {
                print("STATUS:", response.statusCode)
            }

            if let data = data {
                print("RESPONSE:", String(data: data, encoding: .utf8) ?? "No Data")
            }

        }.resume()
    }

    // MARK: - Cardholders
    func fetchCardholders(completion: @escaping ([Cardholder]) -> Void) {

        guard let url = URL(string: "\(baseURL)/cardholders") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, _, error in

            if let error = error {
                print("❌ cardholders error:", error)
                DispatchQueue.main.async { completion([]) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(CardholderResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(decoded.results)
                }

            } catch {

                print("decode cardholders error:", error)
                print(String(data: data, encoding: .utf8) ?? "")

                DispatchQueue.main.async {
                    completion([])
                }
            }

        }.resume()
    }
    //MARK: - CardholderDetail
    func fetchCardholderDetail(id: String, completion: @escaping (CardholderDetail?) -> Void) {

        guard let url = URL(string: "\(baseURL)/cardholders/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, _, error in

            if let error = error {
                print("detail error:", error)
                DispatchQueue.main.async { completion(nil) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(CardholderDetail.self, from: data)

                DispatchQueue.main.async {
                    completion(decoded)
                }

            } catch {

                print("decode detail error:", error)
                print(String(data: data, encoding: .utf8) ?? "")

                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()
    }

    // MARK: - Doors
    func fetchDoors(completion: @escaping ([Door]) -> Void) {

        guard let url = URL(string: "\(baseURL)/doors") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, _, error in

            if let error = error {
                print("❌ doors error:", error)
                DispatchQueue.main.async { completion([]) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(DoorResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(decoded.results)
                }

            } catch {

                print("decode doors error:", error)
                print(String(data: data, encoding: .utf8) ?? "")

                DispatchQueue.main.async {
                    completion([])
                }
            }

        }.resume()
    }

    // MARK: - Events
    func fetchEvents(completion: @escaping ([Event]) -> Void) {

        guard let url = URL(string: "\(baseURL)/events?top=100&previous=true") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        let session = URLSession(configuration: .default, delegate: SSLBypassDelegate(), delegateQueue: nil)

        session.dataTask(with: request) { data, response, error in

            guard let data = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(EventResponse.self, from: data)

                // newest -> oldest
                let sorted = decoded.events.sorted {
                    $0.time > $1.time
                }

                DispatchQueue.main.async {
                    completion(Array(sorted.prefix(100)))
                }

            } catch {

                print("decode error events:", error)

                if let raw = String(data: data, encoding: .utf8) {
                    print(raw)
                }

                DispatchQueue.main.async {
                    completion([])
                }
            }

        }.resume()
    }


    // MARK: - Competencies
    func fetchCompetencies(completion: @escaping ([Competency]) -> Void) {

        guard let url = URL(string: "\(baseURL)/competencies") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, _, error in

            if let error = error {
                print("❌ competencies error:", error)
                DispatchQueue.main.async { completion([]) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(CompetencyResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(decoded.results)
                }

            } catch {

                print("decode competencies error:", error)
                print(String(data: data, encoding: .utf8) ?? "")

                DispatchQueue.main.async {
                    completion([])
                }
            }

        }.resume()
    }

    // MARK: - Competency Detail
    func fetchCompetencyDetail(id: String, completion: @escaping (CompetencyDetail?) -> Void) {

        guard let url = URL(string: "\(baseURL)/competencies/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, _, error in

            if let error = error {
                print("❌ competency detail error:", error)
                DispatchQueue.main.async { completion(nil) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(CompetencyDetail.self, from: data)

                DispatchQueue.main.async {
                    completion(decoded)
                }

            } catch {

                print("decode competency detail error:", error)
                print(String(data: data, encoding: .utf8) ?? "")

                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()
    }

    // MARK: - Access Zones
    func fetchAccessZones(completion: @escaping ([AccessZone]) -> Void) {
        guard let url = URL(string: "\(baseURL)/access_zones") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("GGL-API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")

        let session = URLSession(configuration: .default, delegate: SSLBypassDelegate(), delegateQueue: nil)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ ERROR fetchAccessZones:", error)
                DispatchQueue.main.async { completion([]) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(AccessZoneResponse.self, from: data)
                DispatchQueue.main.async { completion(decoded.results) }
            } catch {
                print("decode error accessZones:", error)
                if let raw = String(data: data, encoding: .utf8) {
                    print("RAW JSON:", raw)
                }
                DispatchQueue.main.async { completion([]) }
            }
        }.resume()
    }
}
