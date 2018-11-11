//
//  SettingsViewController.swift
//  PixcellWorking
//
//  Created by Nahar Alamoudi on 11/5/18.
//  Copyright © 2018 Pixcell Inc. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }*/
    
    // settings items list:
    let settingsMenu = ["Change Language", "Terms & Conditions", "Privacy Policy", "Contact Us","FAQs"]
    
    
    
    // Table View 3 mandatory functions:
    
    // 1.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 2.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsMenu.count
    }
    
    // 3.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
       /* if(indexPath.row == 4){  // hide cancel subscription cell
            cell.isHidden = true
        }*/

        
        
        let settingChosen = settingsMenu[indexPath.row]
        
        cell.textLabel?.text = settingChosen
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        return cell
        
    }
    
    // give tableview section title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "General Settings"
    }
    
   // reduce hight of hidden cell to 0, I commented it out because it's the last cell im trying to hide, and i dont need to reduce its hight to 0
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight:CGFloat = 0.0
        
        if(indexPath.row == 4){
            
            rowHeight = 0.0
            
        }
            
        else{
            
            rowHeight = 55.0    //or whatever you like
        }
        
        return rowHeight
    }
 */
    
    func loadData() {
        // code to load data from network, and refresh the interface
        tableView.reloadData()
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "settingsPasser" { return }
        
        if let dest = segue.destination as? SettingsDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            dest.settingsString = settingsMenu[(indexPath as NSIndexPath).row]
        }
    }


}
