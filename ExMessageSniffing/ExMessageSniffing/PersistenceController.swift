//
//  PersistenceController.swift
//  ExMessageSniffing
//
//  Created by 강동영 on 5/16/25.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "MessageModel") // .xcdatamodeld 파일명
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
