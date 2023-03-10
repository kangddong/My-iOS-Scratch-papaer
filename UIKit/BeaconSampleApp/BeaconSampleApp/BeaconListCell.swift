//
//  BeaconListCell.swift
//  BeaconSampleApp
//
//  Created by dongyeongkang on 2023/02/24.
//

import UIKit

class BeaconListCell: UITableViewCell {

    static let identifier: String = String(describing: BeaconListCell.self)
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // FIXME: 재활용성
    var discoveredDate: Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderColor = UIColor.systemOrange.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10,
                                                                      left: 10,
                                                                      bottom: 10,
                                                                      right: 10))
    }
    //FIXME: param 변경
    public func setData(name: String?, RSSI: Double, macAddress: String, now date: Date) {
        var menuInfo = ""
        var convertedString = "-"
        switch macAddress {
        case "AC:23:3F:F6:B4:AF":
            foodImageView.image = UIImage(named: "특식")
             
            menuInfo = "특식 6,000원"
            
        case "AC:23:3F:F6:B4:B1":
            foodImageView.image = UIImage(named: "분식")
            menuInfo = "분식 5,000원"
            
        case "AC:23:3F:F6:B4:A8":
            foodImageView.image = UIImage(named: "일반")
            menuInfo = "일반 8,000원"
            
        default:
            menuInfo = name ?? "no name"
        }
        
        //let discoveredDate: Date = Date()
        if let cellDate = discoveredDate {
            convertedString = String(format: "%.2f",
                                         Float(cellDate.timeIntervalSince(date)))
        } else {
            discoveredDate = Date()
            convertedString = String(format: "%.2f",
                                         Float(discoveredDate!.timeIntervalSince(date)))
        }
        
        titleLabel.text = "\(menuInfo) (거리: \(rssiToDistance(rssi: RSSI)), 인식 시간: \(convertedString)초 )"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
    }
    
    private func rssiToDistance(rssi: Double) -> String {
        let n: Double = 2.0
        let alpha: Double = -63.0
        
        let distance = pow(10.0, ((alpha - rssi) / (10.0 * n)))
        let result = round((distance * 100.0)) / 100.0 // 소수점 두자리만 남겨놓고 나머지 버림.
        return result.description + "M"
    }
}
