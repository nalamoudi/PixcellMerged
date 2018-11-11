//
//  PaymentViewController.swift
//  PixcellWorking
//
//  Created by Muaawia Janoudy on 2018-10-28.
//  Copyright © 2018 Pixcell Inc. All rights reserved.
//

import UIKit
import Firebase

class PaymentViewController: UIViewController {
    
    // MARK: Instance Variables
    var initialSetupViewController: PTFWInitialSetupViewController!
    let ref = Database.database().reference(fromURL: "https://pixcell-working.firebaseio.com/")
    let uid = Auth.auth().currentUser!.uid
    var userEmail = ""
    var userPhone = ""
    var userFirstName = ""
    var userLastName = ""
    var fullAddress: String?
    var amountOwed: Float?
    var userPaid: Bool?
    var didSubmit: Bool?

    
    //let user = Auth.auth().currentUser
    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var transactionStateLabel: UILabel!
    @IBOutlet weak var responseView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextView!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var provinceField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var sameAsShippingSwitch: UISwitch!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var innerResponseView: UIView!
    @IBOutlet weak var dismissTransactionResultButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let total = amountOwed {
            totalLabel.text = "Checkout Total: \(total) SAR"
        }
        dismissTransactionResultButton.layer.borderWidth = 1
        dismissTransactionResultButton.layer.borderColor = UIColor.init(red: 230, green: 230, blue: 230).cgColor
        dismissTransactionResultButton.layer.cornerRadius = 4
        addressField!.layer.borderWidth = 1
        addressField!.layer.borderColor = UIColor.init(red: 230, green: 230, blue: 230).cgColor
        addressField!.layer.cornerRadius = 4
        responseView.layer.cornerRadius = 10
        innerResponseView.layer.cornerRadius = 10
        responseView.isHidden = true
        paymentButton.isEnabled = false
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.userEmail = value?["Email"] as? String ?? ""
            self.userPhone = value?["Phone Number"] as? String ?? ""
            self.userFirstName = value?["First Name"] as? String ?? ""
            self.userLastName = value?["Last Name"] as? String ?? ""
        })
    }
    
    
    @IBAction func toggleSameAsShippingAddress(_ sender: Any) {
        guard let address = fullAddress else {return}
        let addressComponents = address.components(separatedBy: ", ")
        let cityAndZipCode = addressComponents[1].components(separatedBy: " ")
        if sameAsShippingSwitch.isOn {
            let billingAddress = addressComponents[0]
            let billingCity = cityAndZipCode[0]
            let billingZipCode = cityAndZipCode[1]
            var billingProvince: String {
                switch billingCity {
                case "Jeddah", "Makkah", "Mekkah", "Mecca":
                    return "Makkah"
                case "Riyadh":
                    return "Riyadh"
                case "Dammam", "Dahran":
                    return "Sharqiyah"
                case "Madina", "Yanbu":
                    return "Al Madina Al Munawara"
                default:
                    return " "
                }
            }
            nameField.text = "\(userFirstName) \(userLastName)"
            addressField.text = billingAddress
            cityField.text = billingCity
            provinceField.text = billingProvince
            zipCodeField.text = billingZipCode
            enableButton()
        } else {
            nameField.text = ""
            addressField.text = ""
            cityField.text = ""
            provinceField.text = ""
            zipCodeField.text = ""
        }
    }
    
    func enableButton() {
        if sameAsShippingSwitch.isOn {
            paymentButton.isEnabled = true
        } else if !(nameField.text?.isEmpty)! && !((addressField.text?.isEmpty)!) && !((cityField.text?.isEmpty)!) && !((provinceField.text?.isEmpty)!) && !((zipCodeField.text?.isEmpty)!) {
            paymentButton.isEnabled = true
        }
    }
    
    private func initiateSDK() {
        
        guard let billingAddress = addressField.text, let billingCity = cityField.text, let billingProvince = provinceField.text, let billingZipCode = zipCodeField.text, let amount = amountOwed else {return}
        
        guard let address = fullAddress else {return}
        let addressComponents = address.components(separatedBy: ", ")
        let cityAndZipCode = addressComponents[1].components(separatedBy: " ")
        let shippingAddress = addressComponents[0]
        let shippingCity = cityAndZipCode[0]
        let shippingZipcode = cityAndZipCode[1]
        var shippingProvince: String {
            switch shippingCity {
            case "Jeddah", "Makkah", "Mekkah", "Mecca":
                return "Makkah"
            case "Riyadh":
                return "Riyadh"
            case "Dammam", "Dahran":
                return "Sharqiyah"
            case "Madina", "Yanbu":
                return "Al Madina Al Munawara"
            default:
                return " "
            }
        }
        
        let bundle = Bundle(url: Bundle.main.url(forResource: ApplicationResources.kFrameworkResourcesBundle, withExtension: "bundle")!)

        // Mark: Initialize the paytabs SDK with all the required parameters
        
        self.initialSetupViewController = PTFWInitialSetupViewController.init(nibName: "Resources", bundle: bundle, andWithViewFrame: self.view.frame, andWithAmount: amount, andWithCustomerTitle: "Paytabs", andWithCurrencyCode: "SAR", andWithTaxAmount: 0.00, andWithSDKLanguage: "en", andWithShippingAddress: shippingAddress, andWithShippingCity: shippingCity, andWithShippingCountry: "SAU", andWithShippingState: shippingProvince, andWithShippingZIPCode: shippingZipcode, andWithBillingAddress: billingAddress, andWithBillingCity: billingCity, andWithBillingCountry: "SAU", andWithBillingState: billingProvince, andWithBillingZIPCode: billingZipCode, andWithOrderID: "0001", andWithPhoneNumber: "00966\(userPhone.dropFirst())", andWithCustomerEmail: userEmail, andIsTokenization: true, andWithMerchantEmail: "mjanoudy@solarbits.com", andWithMerchantSecretKey: "F5IZyLkWJA2ZDXjWeDbbOYvaZB7HiT9XZRXyChumSxlvvFsJjEU7CqhC2pjkjtiikgQXyljqSFWolp7E32MGt3ivtCQM585ppVnX", andWithAssigneeCode: "SDK", andWithThemeColor: UIColor.init(alpha: 1.0, red: 255, green: 255, blue: 255), andIsThemeColorLight: true)
    
        weak var weakSelf = self
        self.initialSetupViewController.didReceiveBackButtonCallback = {
            weakSelf?.handleBackButtonTappedEvent()
        }
        
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            self.resultLabel.text = "Result: \(result)"
            self.transactionIDLabel.text = "Transaction ID: \(transactionID)"
            if result == "Approved" {
                self.transactionStateLabel.text = "Thank you for your payment"
                self.dismissTransactionResultButton.setTitle("Proceed",for: .normal)
            } else {
                self.transactionStateLabel.text = "Payment declined, please choose another payment method"
                self.dismissTransactionResultButton.setTitle("Dismiss",for: .normal)
            }
            
            self.responseView.isHidden = false
            self.innerResponseView.isHidden = false
            self.ref.child("users/\(self.uid)/Paid").setValue(true)
            
            weakSelf?.handleBackButtonTappedEvent()
        }
    }
    
    @IBAction func sendPaymentButtonTapped(_ sender: Any?) {
        self.initiateSDK()
        let bundle = Bundle(url: Bundle.main.url(forResource: ApplicationResources.kFrameworkResourcesBundle, withExtension: "bundle")!)
        
        if bundle?.path(forResource: ApplicationXIBs.kPTFWInitialSetupView, ofType: "nib") != nil {
            print("exists")
        } else {
            print("not exist")
        }
        
        self.view.addSubview(initialSetupViewController.view)
        self.addChild(initialSetupViewController)
        
        initialSetupViewController.didMove(toParent: self)
    }
    
    
    
    private func handleBackButtonTappedEvent() {
        self.initialSetupViewController.willMove(toParent: self)
        self.initialSetupViewController.view.removeFromSuperview()
        self.initialSetupViewController.removeFromParent()
    }
    
    @IBAction func closeResponsePressed(_ sender: Any?){
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let userPaid = value?["Paid"] as? Bool ?? false
            if userPaid == false {
                self.responseView.isHidden = true
            } else if userPaid == true {
                self.didSubmit = true
                self.performSegue(withIdentifier: "SelectCharitySegue", sender: self)
            }
        })
    }
    
    
    func loadPaymentScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCharitySegue" {
            if let dest = segue.destination as? CharityViewController {
                dest.didSubmit = self.didSubmit
            }
        }
    }

    

}
