//
//  ViewController.swift
//  AmazonCognitoFacebookAuthentication
//
//  Created by Grzegorz Tatarzyn on 03/01/2015.
//  Copyright (c) 2015 Grzegorz Tatarzyn. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBLoginViewDelegate {
    let displayDetialSegueId = "displayDetails"
    
    @IBOutlet weak var showDetailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLogin: FBLoginView = FBLoginView()
        fbLogin.delegate = self
        fbLogin.center = view.center
        
        view.addSubview(fbLogin)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        showDetailsButton.enabled = true
        presentDetailsController()
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        showDetailsButton.enabled = false
    }
    
    @IBAction func showDetailButtonClicked(sender: AnyObject) {
        presentDetailsController();
    }
    
    private func presentDetailsController() {
        performSegueWithIdentifier(displayDetialSegueId, sender: self)
    }
}

