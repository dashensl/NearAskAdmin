//
//  PostsTableViewController.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 5/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit
import FontAwesome

class PostsTableViewController: UITableViewController {

    var dataSource: [PostModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        self.dataSource = [PostModel]()
        self.tableView.delegate = self
        self.fetchFeeds()
        
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func fetchFeeds() {
        var categories = [String]()
        categories.append("1");
        categories.append("2");
        categories.append("3");
        categories.append("4");
        var request = URLRequest(url: URL(string: "http://api-dev.nearask.com/v1/admin/unreadPosts")!)
        let postString = ["jobCategoryIds":categories, "limit": "8", "previousCreatedAt": "",
                          "descending": false, "mediaSizes": ["small", "medium"]] as [String : Any]
        
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
                    
                    let temp: PostModel = PostModel(uuid: element.value(forKey: "uuid") as! String, title: element.value(forKey: "uuid") as! String, formattedPrice: element.value(forKey: "formattedPrice") as! String, description: element.value(forKey: "description") as! String, location: location, user: user, lastUpdateAt: element.value(forKey: "userUpdatedAt") as! String, serviceCategory: category)
                    self.dataSource?.append(temp)
                })

                self.tableView.reloadData()
            } catch {
                print("could not parse data as json\(data)")
                return
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "postcell") as! PostTableViewCell
        let currentpost: PostModel = self.dataSource[indexPath.row]
        cell.nameLabel.text = currentpost.user.username
        cell.descLabel.text = currentpost.description
        cell.priceLabel.text = currentpost.formattedPrice
        cell.titleLabel.text = currentpost.title
        cell.locationLabel.font = UIFont.fontAwesome(ofSize: 12)
        cell.locationLabel.text = String.fontAwesomeIcon(name: .mapMarker) + " " + currentpost.location.name
        cell.timeFromNowLabel.font = UIFont.fontAwesome(ofSize: 12)
        cell.timeFromNowLabel.text = String.fontAwesomeIcon(name: .clockO) + " " + currentpost.lastUpdateAt
        cell.categorynameLabel.text = currentpost.serviceCategory.name
        cell.profileThumbNail.layer.cornerRadius = 5
        cell.profileThumbNail.clipsToBounds = true
        self.downloadImage(url: URL(string: currentpost.user.profileThumbnailUrl)!, cell: cell)
        
        cell.categoryIconLabel.font = UIFont(name: "Nearask", size: 24)
        cell.categoryIconLabel.text = ServiceCategory.getIconBycategoryname(catid: currentpost.serviceCategory.id)
        
        cell.nameLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
        cell.titleLabel.textColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
        cell.descLabel.textColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        cell.categoryIconLabel.textColor = UIColor(red: 84/255, green: 153/255, blue: 219/255, alpha: 1.0)
        cell.categorynameLabel.textColor = UIColor(red: 84/255, green: 153/255, blue: 219/255, alpha: 1.0)
        cell.priceLabel.textColor = UIColor(red: 84/255, green: 153/255, blue: 219/255, alpha: 1.0)
        cell.descLabel.sizeToFit()
        
//        rgb 84 153 219
        return cell
    }
    
    func downloadImage(url: URL, cell: PostTableViewCell) {
//        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                cell.profileThumbNail.image = UIImage(data: data)
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
