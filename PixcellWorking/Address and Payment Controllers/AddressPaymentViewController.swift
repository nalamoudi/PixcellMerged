//
//  AddressPaymentViewController.swift
//  PixcellWorking
//
//  Created by Muaawia Janoudy on 2018-10-31.
//  Copyright © 2018 Pixcell Inc. All rights reserved.
//

import UIKit
import LocationPickerViewController
import Firebase
import MapKit

class AddressPaymentViewController: UIViewController {
    
    let ref = Database.database().reference(fromURL: "https://pixcell-working.firebaseio.com/")
    let uid = Auth.auth().currentUser!.uid
    var userAddress = ""
    var firstAlbumRemainingImages: Int?
    var secondAlbumRemainingImages: Int?
    var albumsCost: Float?
    var didSubmit: Bool?

    @IBOutlet weak var proceedToPaymentOutlet: UIButton!
    @IBOutlet weak var locationAddressLabel: UITextField!
    @IBOutlet weak var cashIcon: UIImageView!
    @IBOutlet weak var creditcardIcon: UIImageView!
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subtotalView: UIView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var VATLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Checkout"
        searchLocationButton.layer.cornerRadius = 4
        creditcardIcon.layer.cornerRadius = 4
        cashIcon.layer.cornerRadius = 4
        submitButton.layer.cornerRadius = 4
        subtotalView.layer.cornerRadius = 4
        cashIcon.isHighlighted = false
        creditcardIcon.isHighlighted = false
        proceedToPaymentOutlet.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard let firstAlbumImagesRemaining = self.firstAlbumRemainingImages, let secondAlbumImagesRemaining = self.secondAlbumRemainingImages, let cost = self.albumsCost else {return}
        
        if firstAlbumImagesRemaining == 0 && secondAlbumImagesRemaining < 50 {
            self.subtotalLabel.text = "\(cost-2.86) SAR"
            self.VATLabel.text = "2.86 SAR"
            self.totalLabel.text = "\(cost) SAR"
        } else if self.firstAlbumRemainingImages! < 50 && self.secondAlbumRemainingImages! == 50 {
            self.subtotalLabel.text = "\(cost - 1.43) SAR"
            self.VATLabel.text = "1.43 SAR"
            self.totalLabel.text = "\(cost) SAR"
        }
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.userAddress = value?["Address"] as? String ?? ""
            //Disable buttons if the address has not been chosen, enable if an address exists
            if self.userAddress == "empty" {
                print("Address is Empty")
            } else {
                self.locationAddressLabel!.text = ("\(self.userAddress)")
            }
        })
        
    }
    
    
    @IBAction func cashOnDeliveryClicked(_ sender: Any) {
        cashIcon.isHighlighted = true
        creditcardIcon.isHighlighted = false
        enablePayment()
    }
    
    @IBAction func crediCardClicked(_ sender: Any) {
        cashIcon.isHighlighted = false
        creditcardIcon.isHighlighted = true
        enablePayment()
    }
    
    func enablePayment () {
        if cashIcon.isHighlighted || creditcardIcon.isHighlighted && locationAddressLabel.text?.isEmpty == false {
            proceedToPaymentOutlet.isEnabled = true
        }
    }
    
    @IBAction func proceedButton(_ sender: Any) {
        if cashIcon.isHighlighted {
            didSubmit = true
            performSegue(withIdentifier: "PayInCashSegue", sender: self)
        } else if creditcardIcon.isHighlighted {
            didSubmit = false
            performSegue(withIdentifier: "CreditCardPaymentSegue", sender: self)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickLocationSegue" {
            let locationPicker = segue.destination as! LocationPicker
            locationPicker.addBarButtons()
            locationPicker.pickCompletion = { (pickedLocationItem) in
                guard let addressString = pickedLocationItem.formattedAddressString else {return}
                let locationName = "\(pickedLocationItem.name), \(addressString), Saudi Arabia"
                let locationCoordinates = "\(pickedLocationItem.coordinate!.latitude),\(pickedLocationItem.coordinate!.longitude)"
                guard let uid = Auth.auth().currentUser?.uid else {return}
                self.ref.child("users/\(uid)/Address").setValue(locationName)
                self.ref.child("users/\(uid)/Location Coordinates").setValue(locationCoordinates)
            }
        } else if segue.identifier == "CreditCardPaymentSegue" {
            let dest = segue.destination as! PaymentViewController
                dest.fullAddress = self.userAddress
                dest.didSubmit = self.didSubmit
            if self.albumsCost == 29.99 {
                dest.amountOwed = 29.99
            } else if self.albumsCost == 59.98 {
                dest.amountOwed = 59.98
            }
        } else if segue.identifier == "PayInCashSegue" {
            let dest = segue.destination as! CharityViewController
            dest.didSubmit = self.didSubmit
            if self.albumsCost == 29.99 {
                dest.amountOwed = 29.99
            } else if self.albumsCost == 59.98 {
                dest.amountOwed = 59.98
            }
        }
    }

}
