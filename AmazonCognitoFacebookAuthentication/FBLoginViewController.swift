//
//  ViewController.swift
//  AmazonCognitoFacebookAuthentication
//
//  Created by Grzegorz Tatarzyn on 03/01/2015.
//  Copyright (c) 2015 Grzegorz Tatarzyn. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBLoginViewDelegate {

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
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("\(user)")
    }
}

