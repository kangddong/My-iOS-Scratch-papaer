//
//  MessageListViewController.swift
//  HelloXcode26
//
//  Created by 강동영 on 6/10/25.
//

import UIKit
import SwiftUI

struct MessageListViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some MessageListViewController {
        MessageListViewController()
    }
}

@Observable class UnreadMessageModel {
    var showStatus: Bool
    var statusText: String
    
    init(showStatus: Bool, statusText: String) {
        self.showStatus = showStatus
        self.statusText = statusText
    }
}

class MessageListViewController: UIViewController {
    var unreadMessageModel: UnreadMessageModel = .init(showStatus: false, statusText: "zero")
    
    var statusLabel: UILabel = .init(frame: .init(x: 200, y: 200, width: 300, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(statusLabel)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            print(#function, "sleep for 3 seconds")
            try await Task.sleep(for: .seconds(3))
            print(#function, "awake !")
            unreadMessageModel.showStatus = true
            unreadMessageModel.statusText = "some"
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        statusLabel.alpha = unreadMessageModel.showStatus ? 1.0 : 0.0
        statusLabel.text = unreadMessageModel.statusText
    }
}


import Playgrounds

#Playground {
    let model = UnreadMessageModel(showStatus: false, statusText: "")
    model.showStatus = true
}
