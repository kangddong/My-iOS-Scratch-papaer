//
//  ColorPickerViewControllerRepresentable.swift
//  HelloXcode26
//
//  Created by 강동영 on 6/10/25.
//

import UIKit
import SwiftUI

struct ColorPickerViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIColorPickerViewController {
        let vc = UIColorPickerViewController()
        vc.maximumLinearExposure = 2.0
        return vc
    }
}

