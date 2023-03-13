//
//  Ex_UIImage.swift
//  ImageOrientationFix
//
//  Created by dongyeongkang on 2023/03/13.
//

import UIKit

extension UIImage {
    
    func rotate(degrees: CGFloat) -> UIImage {
        

        // context에 그려질 크기를 구하기 위해서 최종 회전되었을때의 전체 크기 획득
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let affineTransform: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = affineTransform

        // 회전된 크기
        let rotatedSize: CGSize = rotatedViewBox.frame.size

        // 회전한 만큼의 크기가 있을때, 필요없는 여백 부분을 제거하는 작업
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        // 원점을 이미지의 가운데로 평행 이동
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        // 회전
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        // 상하 대칭 변환 후 context에 원본 이미지 그림 그리는 작업
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))

        // 그려진 context로 부터 이미지 획득
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
    
    /*
     camera에서 take pic 한 Image를 rotate 90 angle 하는 이유
     참조: https://developer.apple.com/documentation/uikit/uiimage/orientation
     the camera sensor's native landscape orientation
     센서를 통해 찍은 사진은 it automatically applies a 90° rotation before displaying the image data 된다고합니다.
     
     Camera에서 촬영 시에 exif(metaData)의  imageOrientation의 Default Value는 .Right 입니다.
     서버에 업로드 시 문제가 됩니다.
     그리하여 .right의 Orientaion을 .up으로 바꿔줘야 서버에 의도한 원본 이미지가 올라가게됩니다.
     */
    /// 서버 업로드시 Orientation이 right인 것을 up 으로 바꿔주는 메소드
    func fixOrientation() -> UIImage {
        
        if (self.imageOrientation == .up) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)
         
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
         
        return normalizedImage
    }
}
