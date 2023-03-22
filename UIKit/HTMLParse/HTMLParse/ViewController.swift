//
//  ViewController.swift
//  HTMLParse
//
//  Created by dongyeongkang on 2023/03/21.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    typealias Item = (text: String, html: String)
    
    var document: Document = Document.init("")
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://apps.apple.com/kr/app/카카오뱅크/id1258016944?uo=4"
        downloadHTML(url: url) { [weak self] in
            self?.parse(document: $0)
        }
    }
}

extension ViewController {
    
    private func downloadHTML(url: String, completionHandler: @escaping (Document?)->()) {
        // url string to URL
        var urlString = url
        if let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString = encodedURL
        }
        guard let url = URL(string: urlString) else {
            // an error occurred
            print("error nil")
            completionHandler(nil)
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let utf8String = String(data: data!, encoding: .utf8)
            do {
                let document = try SwiftSoup.parse(utf8String!)
                completionHandler(document)
            } catch {
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    private func parse(document: Document?) {
        guard let document = document else { return }
        
        do {
            //empty old items
            items = []
            // firn css selector
            let elements: Elements = try document.select("h2")
            //transform it into a local object (Item)
            for element in elements {
                let text = try element.text()
                let html = try element.outerHtml()
                items.append(Item(text: text, html: html))
            }
            items.forEach {
                print($0.text, $0.html)
            }
            
            let subtiles = items.filter { $0.html.contains("subtitle") }.compactMap{ $0 }
            
            print("subtiles = \(subtiles)")
            print("title = \(subtiles.first?.text)")

        } catch let error {
            print("Error: \(error)")
        }

    }
}
