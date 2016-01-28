//
//  ViewController.swift
//  Instagram
//
//  Created by Jiayi Kou on 1/21/16.
//  Copyright © 2016 Jiayi Kou. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data : NSMutableArray = []
    var urlArray : [String] = []
    var userArray : [String] = []
    var profileUrl : [String] = []

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let logo = UIImage(named: "Lux-1.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // Do any additional setup after loading the view, typically from a nib.
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.data = responseDictionary["data"] as! NSMutableArray
                            for object in self.data {
                                let dic = object as! NSDictionary
                                let images = dic["images"] as! NSDictionary
                                let dic1 = object as! NSDictionary
                                let users = dic1["user"] as! NSDictionary
                                let username = users["username"] as! String
                                self.userArray.append(username)
                                
                                let profile = users["profile_picture"] as! String
                                self.profileUrl.append(profile)
                                
                                let lowR = images["low_resolution"] as! NSDictionary
                                let url = lowR["url"] as! String
                                self.urlArray.append(url)
                            }
                            self.tableView.reloadData()
                    }
                    print(self.urlArray)
                }
        });
        task.resume()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell

        let photoURL = NSURL(string:urlArray[indexPath.section])
        let userName = userArray[indexPath.row]
        
        cell.photoID.setImageWithURL(photoURL!)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(red: 65, green: 20, blue: 2, alpha: 0.2)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        // profileView.setImageWithURL(...)
        
        let profileurl = NSURL(string:profileUrl[section])
        profileView.setImageWithURL(profileurl!)
        
        headerView.addSubview(profileView)
        
        // Add a UILabel for the username here
        
        let label = UILabel(frame: CGRect(x: 50, y: 7, width: 200, height: 30))
        label.textColor = UIColor(red: 0, green: 0, blue: 255, alpha: 1)
        let userName = userArray[section]
        label.text = userName
        headerView.addSubview(label)
        return headerView
    }

    

}

