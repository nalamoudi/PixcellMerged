//
//  TabBar.swift
//  PixcellWorking
//
//  Created by Muaawia Janoudy on 2018-11-11.
//  Copyright © 2018 Pixcell Inc. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    /*let ref = Database.database().reference(fromURL: "https://pixcell-working.firebaseio.com/")
    let uid = Auth.auth().currentUser!.uid
    
    var remainingImagesCounter: Int?
    var secondAlbumRemainingImagesCounter: Int?
    var secondAlbumName: String?
    var deliveredValue: Bool?
    var submitted: Bool?*/

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.ref.child("users").child(self.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let remainingImagesFirstAlbum = value?["Remaining Photos"] as? Int ?? 0
            let remainingImagesSecondAlbum = value?["Extra Album Remaining Photos"] as? Int ?? 0
            self.remainingImagesCounter = remainingImagesFirstAlbum
            self.secondAlbumRemainingImagesCounter = remainingImagesSecondAlbum
            self.secondAlbumName = value?["Second Album Name"] as? String ?? "Other Album"
            self.deliveredValue = value?["Delivered"] as? Bool ?? false
            self.submitted = value?["Submitted"] as? Bool ?? false
            let navController = self.viewControllers![1] as! UINavigationController
            let createAlbum = navController.topViewController as! CreateAlbumController
            createAlbum.remainingImagesCounter = self.remainingImagesCounter
            createAlbum.secondAlbumRemainingImagesCounter = self.secondAlbumRemainingImagesCounter
            createAlbum.submitted = self.submitted
            createAlbum.secondAlbumName = self.secondAlbumName
            createAlbum.delivered = self.deliveredValue
        })
    }*/
    
    
    



}
