//
//  FeedsTableViewController.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 12/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit
import FontAwesome
class FeedsTableViewController: UITableViewController {
    
    var dataSource: [PostModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = [PostModel]()
        self.fetchFeeds()
        
        let nib = UINib(nibName: "serviceFeed", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "serviceFeed")
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = tableView.dequeueReusableCell(withIdentifier: "serviceFeed", for: indexPath) as! serviceFeed
        
        let currentpost: PostModel = self.dataSource[indexPath.row]
        feed.setupMedia(medias: currentpost.medias, row: indexPath.row)
        feed.nameLabel.text = currentpost.user.username + "     " + String(currentpost.medias.count)
        feed.descLabel.text = currentpost.description
        feed.priceLabel.text = currentpost.formattedPrice
        feed.titleLabel.text = currentpost.title
        feed.locationLabel.font = UIFont.fontAwesome(ofSize: 12)
        feed.locationLabel.text = String.fontAwesomeIcon(name: .mapMarker) + " " + currentpost.location.name
        feed.timeFromNowLabel.font = UIFont.fontAwesome(ofSize: 12)
        feed.timeFromNowLabel.text = String.fontAwesomeIcon(name: .clockO) + " " + currentpost.lastUpdateAt
        feed.categorynameLabel.text = currentpost.serviceCategory.name
        feed.profileThumbNail.layer.cornerRadius = 5
        feed.profileThumbNail.clipsToBounds = true
        self.downloadImage(url: URL(string: currentpost.user.profileThumbnailUrl)!, imageview: feed.profileThumbNail)
        
        feed.categoryIconLabel.font = UIFont(name: "Nearask", size: 24)
        feed.categoryIconLabel.text = ServiceCategory.getIconBycategoryname(catid: currentpost.serviceCategory.id)
        
        feed.nameLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
        feed.titleLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
        feed.descLabel.textColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        feed.categoryIconLabel.textColor = UIColor(red: 84/255, green: 153/255, blue: 219/255, alpha: 1.0)
        feed.categorynameLabel.textColor = UIColor(red: 84/255, green: 153/255, blue: 219/255, alpha: 1.0)
        feed.priceLabel.textColor = UIColor(red: 84/255, green: 153/255, blue: 219/255, alpha: 1.0)
        feed.descLabel.sizeToFit()
        
        return feed
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentpost: PostModel = self.dataSource[indexPath.row]
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.numberOfLines = 0;
        label.text = currentpost.description
        label.sizeToFit()
        let labelHeight = label.frame.height
        var mediaHeight = 0
        if (currentpost.medias.count < 3 && currentpost.medias.count > 0) {
            mediaHeight = 200
        } else if currentpost.medias.count > 2{
            mediaHeight = 320
        }
        return CGFloat(mediaHeight+130) + labelHeight
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

    func fetchFeeds() {
        var request = URLRequest(url: URL(string: "http://api-dev.nearask.com/v1/admin/unreadPosts")!)
        //        let postString = ["jobCategoryIds": ServiceCategory.getAllCategories(), "limit": "8", "previousCreatedAt": "",
        //                          "descending": true, "mediaSizes": ["small", "medium"]] as [String : Any]
        let postString = ["jobCategoryIds": ServiceCategory.getAllCategories()]
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application-idValue", forHTTPHeaderField: "secret-key")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        let session = URLSession.shared
        session.dataTask(with: request){ data, response, err in
            guard(err == nil) else {
                print("err ======= \(err ?? "no err message" as! Error)")
                return
            }
            // guard: check was any data returned ?
            guard let data = data else{
                print("no data return")
                return
            }
            do {
                let parseResult = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String: AnyObject]
                let posts:[NSDictionary] = parseResult["posts"] as! [NSDictionary]
                posts.forEach({ (element) in
                    let loac = element.object(forKey: "location") as! NSDictionary
                    let location = Location(name: loac.value(forKey: "name") as! String, latitude: loac.value(forKey: "latitude") as! Float, longitude: loac.value(forKey: "longitude") as! Float)
                    
                    let usOb = element.object(forKey: "user") as! NSDictionary
                    let user = User(useruuid: usOb.value(forKey: "uuid") as! String,
                                    username: usOb.value(forKey: "username") as! String,
                                    profileThumbnailUrl: usOb.value(forKey: "profileThumbnailUrl") as! String)
                    
                    let caOb = element.object(forKey: "sourceCategory") as! NSDictionary
                    let category = ServiceCategory(id: caOb.value(forKey: "id") as! NSNumber,
                                                   name: caOb.value(forKey: "name") as! String,
                                                   iconName: caOb.value(forKey: "iconName") as! String,
                                                   backgroundUrl: caOb.value(forKey: "backgroundUrl") as! String)
                    
                    var mediaArray = [Media]()
                    let meOb = element.object(forKey: "media") as! [NSDictionary]
                    
                    meOb.forEach({ (element) in
                        var placeholderurl = ""
                        let mtypeid = element.value(forKey: "mediaTypeId") as! NSNumber
                        let presignedUrls = element.value(forKey: "presignedUrls") as! [NSDictionary]
                        let url = presignedUrls[0].value(forKey: "url") as! NSString
                        if presignedUrls.count > 1 {
                            placeholderurl = presignedUrls[1].value(forKey: "url") as! String
                        }
                        mediaArray.append(Media(mediaTypeId: mtypeid, url: url as String, placeholderUrl: placeholderurl))
                    })
                    
                    let temp: PostModel = PostModel(uuid: element.value(forKey: "uuid") as! String, title: element.value(forKey: "title") as! String, formattedPrice: element.value(forKey: "formattedPrice") as! String, description: element.value(forKey: "description") as! String, location: location, user: user, lastUpdateAt: element.value(forKey: "userUpdatedAt") as! String, serviceCategory: category, medias: mediaArray)
                    self.dataSource?.append(temp)
                })
                
                self.tableView.reloadData()
            } catch {
                print("could not parse data as json\(data)")
                return
            }
            }.resume()
    }

}
