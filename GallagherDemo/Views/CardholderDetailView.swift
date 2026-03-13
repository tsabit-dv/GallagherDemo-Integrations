//
//  CardholderDetailView.swift
//  GallagherDemo
//
//  Created by USER on 9/24/1447 AH.
//

import SwiftUI

struct CardholderDetailView: View {

    let cardholderID: String

    @State private var detail: CardholderDetail?

    var body: some View {

        ScrollView {

            if let detail = detail {

                VStack(alignment: .leading, spacing: 20) {

                    // PROFILE
                    VStack(alignment: .leading, spacing: 6) {

                        Text("\(detail.firstName ?? "") \(detail.lastName ?? "")")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("ID: \(detail.id)")
                            .foregroundColor(.gray)

                        Text(detail.authorised == true ? "Authorised" : "Not Authorised")
                            .foregroundColor(detail.authorised == true ? .green : .red)
                    }

                    Divider()

                    // CARDS
                    VStack(alignment: .leading, spacing: 10) {

                        Text("Cards")
                            .font(.headline)

                        ForEach(detail.cards ?? []) { card in

                            VStack(alignment: .leading) {

                                Text(card.number)

                                Text(card.status?.value ?? "")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }

                    Divider()

                    // COMPETENCIES
                    VStack(alignment: .leading, spacing: 10) {

                        Text("Competencies")
                            .font(.headline)

                        ForEach(detail.competencies ?? []) { comp in

                            VStack(alignment: .leading) {

                                Text(comp.competency.name)

                                if let expiry = comp.expiry {

                                    Text(formatDate(expiry))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }

                    Divider()

                    // CONTACT
                    VStack(alignment: .leading, spacing: 10) {

                        Text("Contact")
                            .font(.headline)

                        if let email = detail.email {
                            Text("Email: \(email)")
                        }

                        if let phone = detail.phone {
                            Text("Phone: \(phone)")
                        }

                        if let address = detail.address {
                            Text("Address: \(address)")
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Cardholder Detail")
        .onAppear {
            loadDetail()
        }
    }

    func loadDetail() {

        GallagherAPIService.shared.fetchCardholderDetail(id: cardholderID) { result in
            self.detail = result
        }
    }

    func formatDate(_ iso: String) -> String {

        let isoFormatter = ISO8601DateFormatter()

        guard let date = isoFormatter.date(from: iso) else {
            return iso
        }

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        formatter.dateFormat = "dd MMMM yyyy HH:mm"

        return formatter.string(from: date)
    }
}
