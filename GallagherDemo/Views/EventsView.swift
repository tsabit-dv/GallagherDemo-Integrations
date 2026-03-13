//
//  EventsView.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI
internal import Combine

struct EventsView: View {

    @State private var events: [Event] = []
    @State private var isLoading = false

    // auto refresh setiap 5 detik
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {

        List(events) { event in

            VStack(alignment: .leading, spacing: 6) {

                Text(event.message)
                    .font(.headline)

                HStack {

                    Text(event.source?.name ?? "Unknown Source")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text("Priority \(event.priority)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Text(formatEventTime(event.time))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Events")

        // tombol refresh manual
        .toolbar {
            Button {
                loadEvents()
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        }

        .onAppear {
            loadEvents()
        }

        // auto refresh
        .onReceive(timer) { _ in
            loadEvents()
        }
    }

    func loadEvents() {

        if isLoading { return }

        isLoading = true

        GallagherAPIService.shared.fetchEvents { result in

            self.events = result

            isLoading = false
        }
    }

    func formatEventTime(_ isoTime: String) -> String {

        let isoFormatter = ISO8601DateFormatter()

        guard let date = isoFormatter.date(from: isoTime) else {
            return isoTime
        }

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        formatter.dateFormat = "dd MMMM yyyy HH:mm:ss"

        return formatter.string(from: date)
    }
}
