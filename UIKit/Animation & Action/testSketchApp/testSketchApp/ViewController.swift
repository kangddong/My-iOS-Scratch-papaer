//
//  ViewController.swift
//  testSketchApp
//
//  Created by dongyeongkang on 2022/09/30.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var brushColor: CGColor = UIColor.black.cgColor
    var brushWidth: CGFloat = 2.0
    var lastPotint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
    }
    
    private func initConfig() {
        
        deleteButton.addTarget(self, action: #selector(clearImage), for: .touchUpInside)
    }
    
    @objc private func clearImage() {
        canvas.image = nil
    }
    
    
    @IBAction func moveVC(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewerVC") as? ImageViewerVC else { return }
        
        vc.image = canvas.image
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension ViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let uiTouch = touch as UITouch
        lastPotint = uiTouch.location(in: canvas)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        UIGraphicsBeginImageContext(canvas.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(brushColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(brushWidth)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        
        let uiTouch = touch as UITouch
        let currentPoint = uiTouch.location(in: canvas)
        
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: canvas.frame.size.width, height: canvas.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPotint.x, y: lastPotint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPotint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIGraphicsBeginImageContext(canvas.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(brushColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(brushWidth)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: canvas.frame.size.width, height: canvas.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPotint.x, y: lastPotint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPotint.x, y: lastPotint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

