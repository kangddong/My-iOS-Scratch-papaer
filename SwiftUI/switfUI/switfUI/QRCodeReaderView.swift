//
//  QRCodeReaderView.swift
//  switfUI
//
//  Created by dongyeongkang on 2022/09/06.
//

import SwiftUI
import AVFoundation

public class QRCodeReaderView: UIView {
    var session: AVCaptureSession!
    
    func setupSession() {
        session = AVCaptureSession()
        session.beginConfiguration()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }

        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
        guard session.canAddInput(videoInput) else { return }
        session.addInput(videoInput)

        let output = AVCaptureMetadataOutput()
        guard session.canAddOutput(output) else { return }
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr, .ean13, .ean8]
        session.commitConfiguration()
    }
    
    func setupPreview() {
            self.frame = CGRect(x: 0, y: 0, width: 500, height: 500)

            let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            previewLayer.frame = self.frame
            
            self.layer.addSublayer(previewLayer)

            self.session.startRunning()
        }
}

extension QRCodeReaderView: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue
            else { return }
            
            print(stringValue)
        }
    }
}

public struct QRCodeReaderPreview: UIViewRepresentable {
    public func updateUIView(_ uiView: UIViewType, context: Context) {
     
    }
    
    public func makeUIView(context: Context) -> some QRCodeReaderView {
        let view = QRCodeReaderView()
        view.setupSession()
        view.setupPreview()
        return view
    }
    
}

