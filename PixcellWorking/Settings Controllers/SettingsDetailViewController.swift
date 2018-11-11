//
//  SettingsDetailViewController.swift
//  PixcellWorking
//
//  Created by Nahar Alamoudi on 11/6/18.
//  Copyright © 2018 Pixcell Inc. All rights reserved.
//

import UIKit

class SettingsDetailViewController: UIViewController {
    
    var settingsString: String?
    
   
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var languageLabelEnglish: UILabel!
    @IBOutlet weak var languageLabelArabic: UILabel!
    @IBOutlet weak var languageSegmentedChoice: UISegmentedControl!
    @IBOutlet weak var viewSegmented: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        viewSegmented.layer.cornerRadius = 10
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        textField.isHidden = false
        languageLabelArabic.isHidden = true
        languageLabelEnglish.isHidden = true
        languageSegmentedChoice.isHidden = true
        viewSegmented.isHidden = true
        
        if let settingsString = settingsString {
            
            if settingsString == "Terms & Conditions"{
                let text = "Terms & Conditions \n\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
                
                textField.attributedText = attributedText(text,settingsString)
                
            } else if settingsString == "Privacy Policy" {
                let text = "Privacy Policy \n\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
                
                textField.attributedText = attributedText(text,settingsString)
                
            } else if settingsString == "Contact Us" {
                let text = "Contact Us \n\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
                
                textField.attributedText = attributedText(text, settingsString)
                
            } else if settingsString == "FAQs" {
                let text = "FAQs \n\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
                
                textField.attributedText = attributedText(text, settingsString)
                
            } else if settingsString == "Change Language" {
                textField.isHidden = true
                languageLabelArabic.isHidden = false
                languageLabelEnglish.isHidden = false
                languageSegmentedChoice.isHidden = false
                viewSegmented.isHidden = false
                
            }
                
        }
    }
    
    func attributedText(_ text: String, _ title: String) -> NSAttributedString {
        
        let string = text as NSString
        
        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
        
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)]
        
        // Part of string to be bold
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: title))
       // attributedString.addAttributes(boldFontAttribute, range: string.range(of: "PLEASE NOTE:"))
        
        // 4
        return attributedString
    }
    

}
