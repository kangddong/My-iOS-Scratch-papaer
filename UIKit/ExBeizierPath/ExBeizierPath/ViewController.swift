//
//  ViewController.swift
//  ExBeizierPath
//
//  Created by 강동영 on 1/17/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pentagon = CAShapeLayer()
        pentagon.fillColor = UIColor.systemGreen.cgColor
        pentagon.path = createRoundedPentagonPath(in: view.frame, cornerRadius: 40)
        pentagon.position = CGPoint(x: 0, y: 100)
        view.layer.addSublayer(pentagon)
        
        // https://stackoverflow.com/questions/20442203/uibezierpath-triangle-with-rounded-edges
        func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
            // Draw the triangle path with its origin at the center.
            // -110, 100
            // 0, -100
            // 110. 100
            let point1 = CGPoint(x: -width / 2, y: height / 2)
            let point2 = CGPoint(x: 0, y: -height / 2)
            let point3 = CGPoint(x: width / 2, y: height / 2)
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
            path.closeSubpath()
            
            return path
        }
        
        func createRoundedPentagonPath(in rect: CGRect, cornerRadius: CGFloat) -> CGMutablePath {
            let path = CGMutablePath()
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2.5  // 오각형 크기 조정
            
            var points: [CGPoint] = []
            for i in 0..<5 {
                let angle = CGFloat(i) * (2 * .pi / 5) - .pi / 2  // 72도 간격
                let x = center.x + radius * cos(angle)
                let y = center.y + radius * sin(angle)
                points.append(CGPoint(x: x, y: y))
            }
            
            // 경로 시작 (첫 번째 점으로 이동)
            path.move(to: points[0])
            
            // 오각형의 5개 변을 따라 둥근 모서리 추가
            for i in 0..<5 {
                let nextIndex = (i + 1) % 5
                path.addArc(tangent1End: points[i], tangent2End: points[nextIndex], radius: cornerRadius)
            }
            
            path.addArc(tangent1End: points[0],
                        tangent2End: points[1],
                        radius: cornerRadius)
            path.closeSubpath()
            return path
        }
    }
    
    
}

import UIKit

class PentagonView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let path = UIBezierPath()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius: CGFloat = min(rect.width, rect.height) / 2.5
        let angle = CGFloat.pi * 2 / 5  // 360도 / 5
        
        for i in 0..<5 {
            let x = center.x + radius * cos(angle * CGFloat(i) - CGFloat.pi / 2)
            let y = center.y + radius * sin(angle * CGFloat(i) - CGFloat.pi / 2)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.close()
        
        UIColor.blue.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        UIColor.blue.withAlphaComponent(0.2).setFill()
        path.fill()
    }
}









#Preview {
    ViewController()
}
