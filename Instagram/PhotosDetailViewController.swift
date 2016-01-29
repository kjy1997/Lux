//
//  PhotosDetailViewController.swift
//  Instagram
//
//  Created by Jiayi Kou on 1/28/16.
//  Copyright © 2016 Jiayi Kou. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController {

    @IBOutlet var photoView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    var photoURL : String!
    var data : NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(photoURL)
        photoView.setImageWithURL(NSURL(string: self.photoURL)!)

        for object in data{
        let comments = data["caption"] as! NSDictionary
        let text = comments["text"] as! String
            captionLabel.text = text
            
        }
          captionLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
