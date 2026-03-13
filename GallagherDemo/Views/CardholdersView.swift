//
//  CardholdersView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

struct CardholdersView: View {

    @State private var cardholders: [Cardholder] = []

    var body: some View {

        List(cardholders) { holder in

            NavigationLink(
                destination: CardholderDetailView(cardholderID: holder.id)
            ) {

                VStack(alignment: .leading) {

                    Text(holder.fullName)
                        .font(.headline)

                    Text("ID: \(holder.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Cardholders")
        .onAppear {
            loadCardholders()
        }
    }

    func loadCardholders() {

        GallagherAPIService.shared.fetchCardholders { result in
            self.cardholders = result
        }
    }
}
