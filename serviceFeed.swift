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
    
    
    func setupMedia(medias: [Media], row: Int) {
    
        print("medias ===\(medias.count)   \(mediaGallery.frame)  row ==\(row)")
        var fullImageHeight = 200
        if (medias.count < 1) {
            return
        }
        switch medias.count {
        case 1:
            let uiimage: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth, height: fullImageHeight))
            uiimage.sd_setImage(with: URL(string: medias[0].url)!)
            self.mediaGallery.addSubview(uiimage)
            break
        case 2:
            let uiimage1: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth/2 , height: fullImageHeight))
            uiimage1.sd_setImage(with: URL(string: medias[0].url)!)
            
            let uiimage2: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: 0, width: fullImageWidth/2, height: fullImageHeight))
            uiimage2.sd_setImage(with: URL(string: medias[1].url)!)
            
            self.mediaGallery.addSubview(uiimage1)
            self.mediaGallery.addSubview(uiimage2)
            break
        case 3:
            fullImageHeight = 320
            let uiimage1: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
            uiimage1.sd_setImage(with: URL(string: medias[0].url)!)
            
            let uiimage2: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
            uiimage2.sd_setImage(with: URL(string: medias[1].url)!)
            
            let uiimage3: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: fullImageHeight/2+imageMargin, width: fullImageWidth, height: fullImageHeight/2))
            uiimage3.sd_setImage(with: URL(string: medias[2].url)!)
            
            self.mediaGallery.addSubview(uiimage1)
            self.mediaGallery.addSubview(uiimage2)
            self.mediaGallery.addSubview(uiimage3)
            break
            
        case 4:
            fullImageHeight = 320
            let uiimage1: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
            uiimage1.sd_setImage(with: URL(string: medias[0].url)!)
            
            let uiimage2: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: 0, width: fullImageWidth/2, height: fullImageHeight/2))
            uiimage2.sd_setImage(with: URL(string: medias[1].url)!)
            
            let uiimage3: UIImageView = UIImageView(frame: CGRect(x: imageMargin, y: fullImageHeight/2+3, width: fullImageWidth/2, height: fullImageHeight/2))
            uiimage3.sd_setImage(with: URL(string: medias[2].url)!)
            
            let uiimage4: UIImageView = UIImageView(frame: CGRect(x: imageMargin*2+fullImageWidth/2, y: fullImageHeight/2+imageMargin, width: 150, height: 90))
            uiimage4.sd_setImage(with: URL(string: medias[3].url)!)
            
            self.mediaGallery.addSubview(uiimage1)
            self.mediaGallery.addSubview(uiimage2)
            self.mediaGallery.addSubview(uiimage3)
            self.mediaGallery.addSubview(uiimage4)
            break
        default: break
            
        }
    }
    
    func downloadImage(url: URL, imageview: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                imageview.image = UIImage(data: data)
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
