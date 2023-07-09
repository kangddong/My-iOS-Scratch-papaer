//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by dongyeongkang on 2023/07/09.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        print(#function)
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = bestAttemptContent else { return }
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
        
        let imageURLString = request.content.userInfo["image"] as! String
        do {
            // 이미지 타입으로 저장하지 않으면 error나므로 주의 (.png, .jpg 등으로 할 것)
            try saveFile(id: "myImage.png", imageURLString: imageURLString) { fileURL in
                do {
                    print(fileURL.absoluteURL)
                    let attachment = try UNNotificationAttachment(identifier: "", url: fileURL, options: nil)
                    bestAttemptContent.attachments = [attachment]
                    contentHandler(bestAttemptContent)
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

    private func saveFile(id: String, imageURLString: String, completion: (_ fileURL: URL) -> Void) throws {
        let fileManager = FileManager.default
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentDirectory.appendingPathComponent(id)
        
        guard
            let imageURL = URL(string: imageURLString),
            let data = try? Data(contentsOf: imageURL)
        else { throw URLError(.cannotDecodeContentData) }
        try data.write(to: fileURL)
        completion(fileURL)
    }
}
