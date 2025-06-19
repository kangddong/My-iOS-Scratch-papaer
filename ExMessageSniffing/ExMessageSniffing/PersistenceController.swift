//
//  PersistenceController.swift
//  ExMessageSniffing
//
//  Created by 강동영 on 5/16/25.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "MessageModel") // .xcdatamodeld 파일명
        
        // App Group 내 위치로 설정
        if let appGroupURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.arex.ExMessageSniffing.depositFilter") {
            let sqliteURL = appGroupURL.appendingPathComponent("FilteredMessage.sqlite")
            let description = NSPersistentStoreDescription(url: sqliteURL)
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func save(message: String, date: Date) {
        let context = container.viewContext
        let newMessage = Message(context: context)
        newMessage.body = message
        newMessage.receivedAt = date
        
        do {
            try context.save()
        } catch {
            print("❌ Failed to save message: \(error)")
        }
    }
    
    // MARK: - Read
    
    func readAllMessages() -> [Message] {
        let context = container.viewContext
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "receivedAt", ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch messages: \(error)")
            return []
        }
    }
}
