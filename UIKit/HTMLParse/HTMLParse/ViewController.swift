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
        
        downloadHTML()
    }
    
    func downloadHTML() {
        print(#function)
        // url string to URL
        var urlString = "https://apps.apple.com/kr/app/카카오뱅크/id1258016944?uo=4"
        if let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString = encodedURL
        }
        guard let url = URL(string: urlString) else {
            // an error occurred
            print("error nil")
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let utf8String = String(data: data!, encoding: .utf8)
//            print(utf8String)
            do {
                self.document = try SwiftSoup.parse(utf8String!)
//                print(self.document)
                self.parse()
            } catch {
                
            }
            
        }
        task.resume()
    }
    
    func parse() {
        print(#function)
        do {
            //empty old items
            items = []
            // firn css selector
            let elements: Elements = try document.select("h2")
//            print("elements = \(elements)")
            //transform it into a local object (Item)
            for element in elements {
                let text = try element.text()
                let html = try element.outerHtml()
                items.append(Item(text: text, html: html))
//                print("items = \(items)")
            }
            items.forEach {
                print($0.text, $0.html)
            }
            
            let subtiles = items.filter { $0.html.contains("subtitle") }.flatMap{ $0 }
            
            print("subtiles = \(subtiles)")
            print("title = \(subtiles.first?.text)")

        } catch let error {
            print("Error: \(error)")
        }

    }

}

