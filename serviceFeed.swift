//
//  serviceFeed.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 12/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit
import SDWebImage

class serviceFeed: UITableViewCell {
    
    
    let fullImageWidth = Int(UIScreen.main.bounds.width - 20)
    let imageMargin = 3
    @IBOutlet weak var profileThumbNail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mediaGallery: UIView!
    @IBOutlet weak var timeFromNowLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryIconLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categorynameLabel: UILabel!
    
    func setupMedia(medias: [Media], row: Int, target: serviceFeed) {
        target.mediaGallery.subviews.forEach({ $0.removeFromSuperview() })
        var fullImageHeight = 200
        
        
        if (medias.count < 1) {
            return
        }
        if medias[0].mediaTypeId == 2 {
            print("alert!!!! video detedted")
        } else {
            switch medias.count {
            case 1:
                let uiimage: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth, height: fullImageHeight))
                uiimage.layer.borderWidth = 2
                uiimage.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
                uiimage.sd_setImage(with: URL(string: medias[0].url)!)
                target.mediaGallery.addSubview(uiimage)
                break
            case 2:
                let uiimage1: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth/2 , height: fullImageHeight))
                uiimage1.layer.borderWidth = 2
                uiimage1.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
                uiimage1.sd_setImage(with: URL(string: medias[0].url)!)
                
                let uiimage2: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: 0, width: fullImageWidth/2, height: fullImageHeight))
                uiimage2.sd_setImage(with: URL(string: medias[1].url)!)
                uiimage2.layer.borderWidth = 2
                uiimage2.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
                
                target.mediaGallery.addSubview(uiimage1)
                target.mediaGallery.addSubview(uiimage2)
                break
            case 3:
                fullImageHeight = 320
                let uiimage1: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
                uiimage1.sd_setImage(with: URL(string: medias[0].url)!)
                
                let uiimage2: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
                uiimage2.sd_setImage(with: URL(string: medias[1].url)!)
                
                let uiimage3: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: fullImageHeight/2+imageMargin, width: fullImageWidth, height: fullImageHeight/2))
                uiimage3.sd_setImage(with: URL(string: medias[2].url)!)
                
                target.mediaGallery.addSubview(uiimage1)
                target.mediaGallery.addSubview(uiimage2)
                target.mediaGallery.addSubview(uiimage3)
                
                break
                
            default:
                fullImageHeight = 320
                let uiimage1: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
                uiimage1.sd_setImage(with: URL(string: medias[0].url)!)
                
                let uiimage2: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
                uiimage2.sd_setImage(with: URL(string: medias[1].url)!)
                
                let uiimage3: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: fullImageHeight/2+3, width: fullImageWidth/2, height: fullImageHeight/2))
                uiimage3.sd_setImage(with: URL(string: medias[2].url)!)
                
                let uiimage4: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: fullImageHeight/2+imageMargin, width: fullImageWidth/2, height: fullImageHeight/2))
                uiimage4.sd_setImage(with: URL(string: medias[3].url)!)
                
                if medias.count > 4 {
                    let coverview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
                    coverview.backgroundColor = UIColor.black
                    coverview.alpha = 0.5
                    
                    let uilabel: UILabel = UILabel(frame: CGRect.zero)
                    uilabel.text = "+ \(medias.count-4)"
                    uilabel.textColor = UIColor.white
                    uilabel.font = UIFont(name: "Avenir-Medium", size: 40)
                    uilabel.font = UIFont.boldSystemFont(ofSize: 30)
                    uilabel.sizeToFit()
                    uilabel.center = CGPoint(x: uiimage4.bounds.size.width/2, y: uiimage4.bounds.size.height/2)
                    
                    uiimage4.addSubview(coverview)
                    uiimage4.addSubview(uilabel)
                }
                
                target.mediaGallery.addSubview(uiimage1)
                target.mediaGallery.addSubview(uiimage2)
                target.mediaGallery.addSubview(uiimage3)
                target.mediaGallery.addSubview(uiimage4)
                break
            }
        }
        
    }
}
