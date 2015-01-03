//
//  DetailsViewController.swift
//  AmazonCognitoFacebookAuthentication
//
//  Created by Grzegorz Tatarzyn on 03/01/2015.
//  Copyright (c) 2015 Grzegorz Tatarzyn. All rights reserved.
//


import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveUserDetails(sender: AnyObject) {
    }
}