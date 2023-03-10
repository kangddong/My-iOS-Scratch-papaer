//
//  ViewController.swift
//  qrcodeReader
//
//  Created by dongyeongkang on 2022/08/30.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var preview = UIView()
    private var session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                print(granted)
            }
            break
        default:
            break
        }
        
        preview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(preview)
        basicSetting()
    }
    
    private func basicSetting() {

            // ✅ AVCaptureDevice : capture sessions 에 대한 입력(audio or video)과 하드웨어별 캡처 기능에 대한 제어를 제공하는 장치.
            // ✅ 즉, 캡처할 방식을 정하는 코드.
            guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {

            // ✅ 시뮬레이터에서는 카메라를 사용할 수 없기 때문에 시뮬레이터에서 실행하면 에러가 발생한다.
            fatalError("No video device found")
            }
            do {

                // 2️⃣ 적절한 inputs 설정
                // ✅ AVCaptureDeviceInput : capture device 에서 capture session 으로 media 를 제공하는 capture input.
                // ✅ 즉, 특정 device 를 사용해서 input 를 초기화.
                let input = try AVCaptureDeviceInput(device: captureDevice)

                // ✅ session 에 주어진 input 를 추가.
                session.addInput(input)

                // 3️⃣ 적절한 outputs 설정
                // ✅ AVCaptureMetadataOutput : capture session 에 의해서 생성된 시간제한 metadata 를 처리하기 위한 capture output.
                // ✅ 즉, 영상으로 촬영하면서 지속적으로 생성되는 metadata 를 처리하는 output 이라는 말.
                let output = AVCaptureMetadataOutput()

                // ✅ session 에 주어진 output 를 추가.
                session.addOutput(output)

                // ✅ AVCaptureMetadataOutputObjectsDelegate 포로토콜을 채택하는 delegate 와 dispatch queue 를 설정한다.
                // ✅ queue : delegate 의 메서드를 실행할 큐이다. 이 큐는 metadata 가 받은 순서대로 전달되려면 반드시 serial queue(직렬큐) 여야 한다.
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

                // ✅ 리더기가 인식할 수 있는 코드 타입을 정한다. 이 프로젝트의 경우 qr.
                output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                

                // ✅ 카메라 영상이 나오는 layer 와 + 모양 가이드 라인을 뷰에 추가하는 함수 호출.
                setVideoLayer()
                //setGuideCrossLineView()

                // 4️⃣ startRunning() 과 stopRunning() 로 흐름 통제
                // ✅ input 에서 output 으로의 데이터 흐름을 시작
                session.startRunning()
            }
            catch {
                print("error")
            }
        }
    
    private func setVideoLayer() {
        // 영상을 담을 공간.
        let videoLayer = AVCaptureVideoPreviewLayer(session: session)
        // 카메라의 크기 지정해야 카메라레이어가 표출이 되네 !
        videoLayer.frame = view.layer.bounds
        // 카메라의 비율지정
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(videoLayer)
        
        
        }
}

extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue
            else { return }
            
            print(stringValue)
            // 세션이 열려있는 동안은 계속 찍힘
        }
     
     
    }
}

