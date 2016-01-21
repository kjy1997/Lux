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

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

        let photoURL = NSURL(string:urlArray[indexPath.row])
        
        
        cell.photoID.setImageWithURL(photoURL!)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }


}

