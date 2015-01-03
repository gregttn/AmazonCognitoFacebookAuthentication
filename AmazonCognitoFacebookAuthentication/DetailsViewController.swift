//
//  DetailsViewController.swift
//  AmazonCognitoFacebookAuthentication
//
//  Created by Grzegorz Tatarzyn on 03/01/2015.
//  Copyright (c) 2015 Grzegorz Tatarzyn. All rights reserved.
//


import UIKit

class DetailsViewController: UIViewController {
    private let nickKey: String = "nick"
    private let emailKey: String  = "email"
    
    var cognitoStore: CognitoStore = CognitoStore.connectWithFacebook()
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedIdentity:", name: CognitoStoreReceivedIdentityIdNotification, object: cognitoStore)
        
        cognitoStore.requestIdentity()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveUserDetails(sender: AnyObject) {
        if nicknameTextField.hasText() {
            cognitoStore.saveItem(nickKey, value: nicknameTextField.text)
        }
        
        if emailTextField.hasText() {
            cognitoStore.saveItem(emailKey, value: emailTextField.text)
        }
    }
    
    func receivedIdentity(notification: NSNotification) {
        requestUserInfo()
    }
    
    private func requestUserInfo() {
        cognitoStore.loadInfo(updateDisplayWithUserInfo)
    }
    
    private func updateDisplayWithUserInfo(userInfo: Dictionary<NSObject, AnyObject>) {
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            
            if var nick: String = userInfo[self.nickKey] as? String {
                self.nicknameTextField.text = nick
            }
            
            if var email: String = userInfo[self.emailKey] as? String {
                self.emailTextField.text = email
            }
        })
    }
}