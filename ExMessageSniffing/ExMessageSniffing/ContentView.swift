//
//  ContentView.swift
//  ExMessageSniffing
//
//  Created by 강동영 on 5/16/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MessageListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.messages, id: \.objectID) { message in
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.body ?? "(내용 없음)")
                        .font(.body)
                    if let date = message.receivedAt {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("입금 메시지")
        }
        .onAppear {
            importMessagesFromExtensionIfNeeded()
        }
    }
    
    func importMessagesFromExtensionIfNeeded() {
        let defaults = UserDefaults(suiteName: "group.arex.ExMessageSniffing.depositFilter")
        guard let messages = defaults?.array(forKey: "messageQueue") as? [[String: Any]] else { return }

        for item in messages {
            guard let body = item["body"] as? String,
                  let timestamp = item["timestamp"] as? TimeInterval else { continue }

            PersistenceController.shared.save(message: body, date: Date(timeIntervalSince1970: timestamp))
        }

        defaults?.removeObject(forKey: "messageQueue")
    }

}

#Preview {
    ContentView()
}
