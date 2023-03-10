//
//  ViewController.swift
//  colltest
//
//  Created by dongyeongkang on 2022/07/27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
//    private var imageList: [UIImage] = [UIImage(systemName: "cloud")!,UIImage(systemName: "pencil")!, UIImage(systemName: "trash")!, UIImage(systemName: "folder")!]
    
    private let picker = UIImagePickerController()
    
    private var imageList: [(image: UIImage, type: String)] = [(image: UIImage(named: "nfc")!, type: "ADD")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
        configCollectionView()
        print("\(UIScreen.main.bounds.width) UIScreen.main.bounds.width")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(UIScreen.main.bounds.width) UIScreen.main.bounds.width")
        print("didappear")
    }

    func initUI() {
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        self.imageCollectionView.collectionViewLayout = flowLayout
        imageCollectionView.layer.borderWidth = 1
        imageCollectionView.layer.borderColor = UIColor.blue.cgColor
    }

    
    func configCollectionView() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.clipsToBounds = false
        imageCollectionView.contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
    }
    
    func converImageToData(image: UIImage?, type: String) {
        guard let image = image else { return }
        
        var convertImage: Data? = nil
        
        switch type {
        case "png":
            convertImage = image.pngData()
        case "jpeg":
            convertImage = image.jpegData(compressionQuality: 1)
        default:
            NSLog("Unknown img Type", "%@")
            return
        }
    
        if let imageData = convertImage {
            if imageData.count > 10485760 {
                let resizeImage = resizeImage(image: image, newWidth: 300)
                
                switch type {
                case "png":
                    convertImage = resizeImage.pngData()
                case "jpeg":
                    convertImage = resizeImage.jpegData(compressionQuality: 1)
                default:
                    NSLog("Unknown img Type", "%@")
                    return
                }
            }
        }
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(convertImage!.count))
        NSLog("convertImage count = \(string)", "%@")
        
        insertImageList(image: image)
        
        //reloadCollectionViewPublish.onNext(())
        
    }
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    private func insertImageList(image: UIImage) {
        self.imageList.insert((image: image, type: "IMG"), at: imageList.count - 1)
        
        if imageList.count == 4 {
            self.imageList.removeLast()
        }
        
        imageCollectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        imageList.forEach { (image, type) in
            if type == "IMG" {
                count += 1
            }
            let hidden = (count == 0) ? true : false
            imageCollectionView.isHidden = hidden
        }
        
        //imageCollectionView.isHidden = true
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let tupleItem = imageList[indexPath.row]

        
        if !tupleItem.type.contains("IMG") {
            
        }
        if tupleItem.type == "ADD" {
            cell.configAddView(image: tupleItem.image, hidden: true)
        } else {
            cell.configImageView(image: tupleItem.image, hidden: false)
        }
        
        return cell
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    //cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (imageCollectionView.frame.width - 24 - 32) / 3 ///  3등분
        let size = CGSize(width: width, height: width)
        print("cell하나당 width=\(width)")

        return size
    }
    
    
}



// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var uploadImage: UIImage? = nil
        var type: String = ""
        if let selectedImage = info[.editedImage] as? UIImage {
            uploadImage = selectedImage
        } else if let selectedImage = info[.originalImage] as? UIImage {
            uploadImage = selectedImage
        }
        
        switch picker.sourceType {
        case .photoLibrary:
            if let assetPath = info[.imageURL] as? URL {
                let URLString = assetPath.absoluteString.lowercased()
                
                if (URLString.hasSuffix("png")) {
                    type = "png"
                } else if (URLString.hasSuffix("jpeg")) {
                    type = "jpeg"
                } else if (URLString.hasSuffix("jpg")) {
                    type = "jpeg"
                } else if (URLString.hasSuffix("gif")) {
                    NSLog("hasSuffix gif", "%@")
                    self.dismiss(animated: true, completion: nil)
                    return
                } else {
                    NSLog("Unknown img Type", "%@")
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                //viewModel?.converImageToData(image: uploadImage, type: type)
                self.converImageToData(image: uploadImage, type: type)
            }
            
        case .camera:
            
            let imgName = UUID().uuidString+".jpeg"
            let documentDirectory = NSTemporaryDirectory()
            let localPath = documentDirectory.appending(imgName)
            if let imgData = uploadImage?.jpegData(compressionQuality: 0.3) {
                
                /*
                 camera에서 take pic 한 Image를 rotate 90 angle 하는 이유
                 참조: https://developer.apple.com/documentation/uikit/uiimage/orientation
                 the camera sensor's native landscape orientation
                 센서를 통해 찍은 사진은 it automatically applies a 90° rotation before displaying the image data 된다고한다.
                 */
                
                uploadImage = UIImage(data: imgData)!.rotate(degrees: 90)
                type = "jpeg"
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
            //viewModel?.converImageToData(image: uploadImage, type: type)
            self.converImageToData(image: uploadImage, type: type)
            
        case .savedPhotosAlbum:
            return
        @unknown default:
            return
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func openLibrary() {
        
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            if authStatus == AVAuthorizationStatus.denied {
                
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                    guard let nsUrl = NSURL(string: UIApplication.openSettingsURLString) else { return }
                    let url = nsUrl as URL
                    UIApplication.shared.openURL(url)
                }
                let cancelDefault = UIAlertAction(title: "취소", style: .cancel)
                
                alert.addAction(okAction)
                alert.addAction(cancelDefault)
                
                self.present(alert, animated: true, completion: nil)
                
            } else if authStatus == AVAuthorizationStatus.notDetermined {
                
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                    if granted {
                        DispatchQueue.main.async {
                            self.picker.sourceType = .camera
                            self.present(self.picker, animated: true, completion: nil)
                        }
                    }
                })
            } else {
                
                picker.sourceType = .camera
                present(picker, animated: true, completion: nil)
            }
        } else {
            NSLog("Camera Can't use", "%@")
        }
    }
}

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

