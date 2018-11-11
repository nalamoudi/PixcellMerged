//
//  AccountTableTableViewController.swift
//  PixcellWorking
//
//  Created by Nahar Alamoudi on 11/5/18.
//  Copyright © 2018 Pixcell Inc. All rights reserved.
//

import UIKit

class AccountTableViewController: UIViewController {

    // Outlets
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    
    // Constants
    let firstTableCellID = "firstCell"
    let secondTableCellID = "secondCell"
    
    // Variables
    var firstMenu = ["Phone Number","Password"]
    var secondMenu = ["Total Albums Ordered", "Total Donations"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
        self.firstTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.secondTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source

    
    func callDelegates () {
        firstTableView.delegate = self
        firstTableView.dataSource = self
        secondTableView.delegate = self
        secondTableView.dataSource = self
    }
}



extension AccountTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return firstMenu.count
        } else {
            return secondMenu.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == firstTableView {
            let cell = firstTableView.dequeueReusableCell(withIdentifier: firstTableCellID) as! accountCellView
            cell.configureCell(name:firstMenu[indexPath.row])
            self.firstTableView.tableFooterView = UIView(frame: CGRect.zero)
            return cell
        }else {
            let cell = secondTableView.dequeueReusableCell(withIdentifier: secondTableCellID) as! accountCellView2
            cell.configureCell(name: secondMenu[indexPath.row])
            self.secondTableView.tableFooterView = UIView(frame: CGRect.zero)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == firstTableView {
            return "Account Info"
        } else {
            return "Account History"
        }
    }
    
        
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "settingsPasser" { return }
        if let dest = segue.destination as? AccountDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            dest.accountString = accountMenu[(indexPath as NSIndexPath).row]
        }
    }*/


