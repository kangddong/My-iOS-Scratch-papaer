//
//  ImageViewerVC.swift
//  testSketchApp
//
//  Created by dongyeongkang on 2022/09/30.
//

import UIKit

class ImageViewerVC: UIViewController {

    @IBOutlet weak var viewer: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let image = image else { return }
        viewer.image = image
    }
    

    @IBAction func back(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
