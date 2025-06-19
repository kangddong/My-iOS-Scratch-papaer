//
//  MessageFilterExtension.swift
//  MessageFilter
//
//  Created by 강동영 on 5/16/25.
//

import IdentityLookup

final class MessageFilterExtension: ILMessageFilterExtension, ILMessageFilterQueryHandling {
    func handle(_ queryRequest: ILMessageFilterQueryRequest,
                context: ILMessageFilterExtensionContext,
                completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        let response = ILMessageFilterQueryResponse()
        guard let message = queryRequest.messageBody,
              message.contains("입금") else {
            response.action = .allow
            completion(response)
            return
        }

        let defaults = UserDefaults(suiteName: "group.arex.ExMessageSniffing.depositFilter")
        var queue = defaults?.array(forKey: "messageQueue") as? [[String: Any]] ?? []

        queue.append([
            "body": queryRequest.messageBody ?? "",
            "timestamp": Date().timeIntervalSince1970
        ])

        defaults?.set(queue, forKey: "messageQueue")
        response.action = .transaction
        completion(response)
    }
}
