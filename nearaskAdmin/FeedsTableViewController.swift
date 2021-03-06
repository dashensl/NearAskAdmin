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
    var last_cursor:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = [PostModel]()
        self.fetchFeeds(previousCreatedAt: "")
        
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
        feed.setupMedia(medias: currentpost.medias, row: indexPath.row, target: feed)
        feed.nameLabel.text = currentpost.user.username + "     " + String(currentpost.medias.count)
        feed.descLabel.text = currentpost.description
        feed.priceLabel.text = currentpost.formattedPrice
        feed.titleLabel.text = currentpost.title
        feed.locationLabel.font = UIFont.fontAwesome(ofSize: 12)
        feed.locationLabel.text = String.fontAwesomeIcon(name: .mapMarker) + " " + currentpost.location.name
        feed.timeFromNowLabel.font = UIFont.fontAwesome(ofSize: 12)
        feed.timeFromNowLabel.text = String.fontAwesomeIcon(name: .clockO) + " " + currentpost.lastCreateAt
        feed.categorynameLabel.text = currentpost.serviceCategory.name
        feed.profileThumbNail.layer.cornerRadius = 5
        feed.profileThumbNail.sd_setImage(with: URL(string: currentpost.user.profileThumbnailUrl)!)
        
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.dataSource.count-1 {
            self.fetchFeeds(previousCreatedAt: self.last_cursor)
        }
    }
    
    
    

    func fetchFeeds(previousCreatedAt: String) {
        var request = URLRequest(url: URL(string: "http://api-dev.nearask.com/v1/admin/unreadPosts")!)
        var postString = ["jobCategoryIds": ServiceCategory.getAllCategories(), "limit": "8"] as [String : Any]
        if !previousCreatedAt.isEmpty{
            postString["previousCreatedAt"] = previousCreatedAt
        }
        
        print("fetch feed get called post string == \(postString)")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                    
                    var title = element.object(forKey: "title")
                    if title == nil {
                        title = "no title"
                    }
                    
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
                    
                    let temp: PostModel = PostModel(uuid: element.value(forKey: "uuid") as! String, title: title as! String, formattedPrice: element.value(forKey: "formattedPrice") as! String, description: element.value(forKey: "description") as! String, location: location, user: user, lastCreateAt: element.value(forKey: "createdAt") as! String, serviceCategory: category, medias: mediaArray)
                    self.last_cursor = temp.lastCreateAt
                    print("self.last cursor == \(self.last_cursor)")
                    self.dataSource?.append(temp)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("could not parse data as json\(data)")
                return
            }
            }.resume()
    }

}
