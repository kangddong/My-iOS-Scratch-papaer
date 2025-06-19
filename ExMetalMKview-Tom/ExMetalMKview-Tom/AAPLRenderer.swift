//
//  AAPLRenderer.swift
//  ExMetalMKview-Tom
//
//  Created by 강동영 on 5/20/25.
//

import MetalKit
import simd

class AAPLRenderer: NSObject, MTKViewDelegate {
    let device: MTLDevice

    // The render pipeline generated from the vertex and fragment shaders in the .metal shader file.
    var pipelineState: MTLRenderPipelineState!
    // The command queue used to pass commands to the device.
    let commandQueue: MTLCommandQueue
    // The current size of the view, used as an input to the vertex shader.
    var viewportSize: vector_uint2 = [0,0]
    init(device: MTLDevice, pipelineState: MTLRenderPipelineState, commandQueue: MTLCommandQueue, viewportSize: vector_uint2) {
        self.device = device
        self.pipelineState = pipelineState
        self.commandQueue = commandQueue
        self.viewportSize = viewportSize
    }
    
    init(mtkView: MTKView) {
        
        device = mtkView.device!
        let defaultLibrary: MTLLibrary = device.makeDefaultLibrary()!
        let vertexFunction = defaultLibrary.makeFunction(name: "vertexShader")
        let fragmentFunction = defaultLibrary.makeFunction(name: "fragmentShader")
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Simple Pipeline"
        pipelineStateDescriptor.vertexFunction = vertexFunction
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        
        
        do {
            try pipelineState = device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
            
        } catch {
            print(error.localizedDescription)
        }
        
        commandQueue = device.makeCommandQueue()!
        super.init()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        viewportSize.x = UInt32(size.width)
        viewportSize.y = UInt32(size.height)
    }
    
    func draw(in view: MTKView) {
        let triangleVertices: [AAPLVertex] = [
            .init(position: [ 250, -250], color: [1, 0, 0, 1]),
            .init(position: [-250, -250], color: [0, 1, 0, 1]),
            .init(position: [   0,  250], color: [0, 0, 1, 1]),
        ]
        
        // Create a new command buffer for each render pass to the current drawable.
        let commandBuffer: MTLCommandBuffer = commandQueue.makeCommandBuffer()!
        commandBuffer.label = "MyCommand"

        // Obtain a renderPassDescriptor generated from the view's drawable textures.
        let renderPassDescriptor: MTLRenderPassDescriptor? = view.currentRenderPassDescriptor

        guard renderPassDescriptor != nil else  { return }
            // Create a render command encoder.
        let renderEncoder: MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)!
            renderEncoder.label = "MyRenderEncoder"

            // Set the region of the drawable to draw into.
        let mtlViewport = MTLViewport(
            originX: 0.0,
            originY: 0.0,
            width: Double(viewportSize.x),
            height: Double(viewportSize.y),
            znear: 0.0,
            zfar: 1.0
        )
        renderEncoder.setViewport(mtlViewport)
        renderEncoder.setRenderPipelineState(pipelineState!)
        
        // Pass in the parameter data.
        renderEncoder.setVertexBytes(
            triangleVertices,
//            length: 96,
            length: MemoryLayout<AAPLVertex>.stride * triangleVertices.count,
//            length: MemoryLayout.size(ofValue: triangleVertices),
            index: Int(AAPLVertexInputIndexVertices.rawValue)
        )
        
        renderEncoder.setVertexBytes(
            &viewportSize,
            length: MemoryLayout.size(ofValue: viewportSize),
            index: Int(AAPLVertexInputIndexViewportSize.rawValue)
        )
        
        // Draw the triangle.
        renderEncoder.drawPrimitives(
            type: .triangle,
            vertexStart: 0,
            vertexCount: 3
        )
        renderEncoder.endEncoding()
        // Schedule a present once the framebuffer is complete using the current drawable.
        commandBuffer.present(view.currentDrawable!)
        // Finalize rendering here & push the command buffer to the GPU.
        commandBuffer.commit()
    }
}
