//
//  ViewController.swift
//  ExercisePasteString
//
//  Created by dongyeongkang on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var pasteButton: UIButton!
    @IBOutlet weak var pasteTextfield: UITextField!
    
    let toastView: UIView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 30)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pasteButton.addTarget(self, action: #selector(pasteSerialNumber), for: .touchUpInside)
    }
    
    @objc
    func pasteSerialNumber() {
        print("paste String")
        UIPasteboard.general.string = serialNumber.text
        
        makeToast {
            DispatchQueue.main.async {
                self.deleteToast()
            }
        }
        
    }
    
    private func makeToast(complete: ()->()) {
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.backgroundColor = .black
        toastView.alpha = 0.5
        toastView.layer.cornerRadius = 8
        
        let toastMessage: UILabel = UILabel()
        toastMessage.translatesAutoresizingMaskIntoConstraints = false
        toastMessage.textAlignment = .center
        toastMessage.font = UIFont.boldSystemFont(ofSize: 16)
        toastMessage.textColor = .white
        toastMessage.text = "복사 되었습니다."
        toastMessage.sizeToFit()
        
        toastView.addSubview(toastMessage)
        view.addSubview(toastView)
        
        NSLayoutConstraint.activate([
            
            toastView.widthAnchor.constraint(equalToConstant: toastView.bounds.width),
            toastView.heightAnchor.constraint(equalToConstant: toastView.bounds.height),
            toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            toastMessage.centerXAnchor.constraint(equalTo: toastView.centerXAnchor),
            toastMessage.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
        ])
        complete()
    }
    
    private func deleteToast() {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn]) {
            self.toastView.alpha = 0.0
            
        } completion: { bool in
            if bool {
                self.toastView.removeFromSuperview()
            }
        }
    }
}

