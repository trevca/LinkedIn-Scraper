//
//  ViewController.swift
//  LinkedInScraper
//
//  Created by Trevor Carpenter on 2/24/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var URLTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goPressed(_ sender: Any) {
        
        guard let url = URLTextField.text else {
            print("Text Field Error")
            return
        }
        
        
    }
    
}

