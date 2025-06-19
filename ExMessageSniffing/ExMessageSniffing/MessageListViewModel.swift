//
//  MessageListViewModel.swift
//  ExMessageSniffing
//
//  Created by 강동영 on 5/17/25.
//


import Foundation

final class MessageListViewModel: ObservableObject {
    @Published var messages: [Message] = []

    init() {
        fetchMessages()
    }

    func fetchMessages() {
        messages = PersistenceController.shared.readAllMessages()
    }
}
