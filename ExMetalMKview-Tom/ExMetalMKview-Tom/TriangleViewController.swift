//
//  TriangleViewController.swift
//  ExMetalMKview-Tom
//
//  Created by 강동영 on 5/20/25.
//

import UIKit
import MetalKit

class TriangleViewController: UIViewController {
    var _view: MTKView = MTKView()
    var renderer: AAPLRenderer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        _view.frame = self.view.bounds
        self.view = _view
        _view.device = MTLCreateSystemDefaultDevice()
        
        assert(_view.device != nil, "Metal is not supported on this device")
        
        renderer = AAPLRenderer(mtkView: _view)
        
        assert(renderer != nil, "Metal is not supported on this device")
        
        // Initialize our renderer with the view size
        renderer.mtkView(_view, drawableSizeWillChange: _view.drawableSize)
//        <MTKView: 0x10380a650; frame = (0 0; 440 956); autoresize = W+H; layer = <CAMetalLayer: 0x600000c5f630>>
//        po _view.drawableSize
//        (width = 1320, height = 2868)
        _view.delegate = renderer
    }
}
