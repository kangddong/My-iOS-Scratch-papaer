//
//  ViewController.swift
//  ExMetalMKview-Tom
//
//  Created by 강동영 on 5/6/25.
//

import UIKit

import MetalKit

class ViewController: UIViewController {
    var metalView: MTKView
    var pipelineState: MTLRenderPipelineState?
    var metalDevice: MTLDevice
    var metalCommandQueue: MTLCommandQueue
    
    init(metalView: MTKView, pipelineState: MTLRenderPipelineState? = nil, metalDevice: MTLDevice, metalCommandQueue: MTLCommandQueue) {
        self.metalView = metalView
        self.pipelineState = pipelineState
        self.metalDevice = metalDevice
        self.metalCommandQueue = metalCommandQueue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    ...
    
    private func setupMetal() {
        metalView.delegate = self
    }
    
    private func setupPipelineState() {
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
//        pipelineDescriptor.vertexFunction = vertexFunction
//        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            pipelineState = try metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Failed to create pipeline state")
        }
    }
}


extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // 뷰 크기 변경 시 처리 (여기서는 비워둠)
    }
    
    func draw(in view: MTKView) {
        guard
            let pipelineState,
            let drawable            = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor,
            let commandBuffer       = metalCommandQueue.makeCommandBuffer(),
            let renderEncoder       = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else { return }
        
        // 파이프라인 상태 설정
        renderEncoder.setRenderPipelineState(pipelineState)
        // 삼각형 드로우
        renderEncoder.drawPrimitives(
            type: .triangle,
            vertexStart: 0,
            vertexCount: 3
        )
        renderEncoder.endEncoding()
        
        // 화면에 표시하고 커밋
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
