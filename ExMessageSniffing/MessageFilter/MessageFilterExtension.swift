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

        defer {
            let response = ILMessageFilterQueryResponse()
            response.action = .allow // 필터링은 하지 않음
            completion(response)
        }

        guard let message = queryRequest.messageBody?.lowercased(),
              message.contains("입금") else { return }

        let defaults = UserDefaults(suiteName: "group.com.example.depositfilter")
        var queue = defaults?.array(forKey: "messageQueue") as? [[String: Any]] ?? []

        queue.append([
            "body": queryRequest.messageBody ?? "",
            "timestamp": Date().timeIntervalSince1970
        ])

        defaults?.set(queue, forKey: "messageQueue")
    }
}
