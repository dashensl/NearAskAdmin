//
//  PostsTableViewController.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 5/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var dataSource: [PostModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let postString = ["jobCategoryIds":categories, "limit": "8", "previousCreatedAt": ""] as [String : Any]
        
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
                    let temp: PostModel = PostModel(title: element.value(forKey: "title") as! String, formattedPrice: element.value(forKey: "formattedPrice") as! String, description: element.value(forKey: "description") as! String, userUpdatedAt: element.value(forKey: "userUpdatedAt") as! String)
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
        cell.nameLabel.text = currentpost.title
        cell.descrLabel.text = currentpost.description
        return cell
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
