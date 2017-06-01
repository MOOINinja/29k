//
//  StartViewController.swift
//  29K
//
//  Created by Patrik Adolfsson on 2017-04-28.
//  Copyright © 2017 Chibi Anward. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FacebookLogin
import AVFoundation

class StartViewController: UIViewController {
    
    //Video
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 59, green: 89, blue: 152, alpha: 1)
        button.setImage(UIImage(named: "facebook_logo"), for: .normal)
        button.setImage(UIImage(named: "facebook_logo"), for: .highlighted)
        button.setTitle("Login", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Logo_Start")
        view.contentMode = .scaleAspectFill
        //view.backgroundColor = UIColor.rgb(red: 10, green: 10, blue: 10, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Login"
        
        let theURL = Bundle.main.url(forResource:"29k_appvideo", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 5
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        //LOGO
        view.addSubview(logoView)
        logoView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // TODO: Check if user already has loggedin and get data from stored data
        let defaults = UserDefaults.standard
        let userToken = defaults.object(forKey: "UserToken")
        if ( userToken != nil ) {
            AppDelegate.instance().showActivityIndicator()
            let dataHandler = DataHandler()
            Variables.UserToken = userToken as! String
            dataHandler.getUser(userToken: Variables.UserToken) { user in
                dataHandler.getCourses() { success in  }
                
                
                
                dataHandler.getCards() { success in
                    Variables.ShowOnbordingAtStart = true
                    self.dismiss(animated: false, completion: nil)
                    
                    
                    //DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadProfile"), object: nil)
                    //}
                    
                    AppDelegate.instance().dismissActivityIndicator()
                    if( Variables.userIsTeamster == true) {
                        dataHandler.getTeamInvites(teamId: (Variables.Teams[Variables.Teams.count-1].id))
                    }
                    
                    dataHandler.orderFindYourFlowStates() { success in }
                }
                
                
                dataHandler.getAllUsers()
            }
            
            
        } else {
        
        // Handle clicks on the button
        loginButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        // Add the button to the view
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 80, paddingBottom: 30, paddingRight: -80, width: 0, height: 50)
        }
        
    }
    
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    
    
    // Once the button is clicked, show the login dialog
    @objc func logIn() {
        
        self.loginButton.isHidden = true
        self.loginButton.isEnabled = false
        AppDelegate.instance().showActivityIndicator()
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email, .custom("user_birthday")], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                self.loginButton.isHidden = false
                self.loginButton.isEnabled = true
                AppDelegate.instance().dismissActivityIndicator()
                print(error)
            case .cancelled:
                print("User cancelled login.")
                AppDelegate.instance().dismissActivityIndicator()
                self.loginButton.isHidden = false
                self.loginButton.isEnabled = true
            case .success( _,  _, let accessToken):
                
                Variables.FacebookToken = accessToken.authenticationToken
                
                self.view.isHidden = false
                
                let dataHandler = DataHandler()
                
                dataHandler.loginWithFaceBookToken(facebookToken: accessToken.authenticationToken) {complete in
                    dataHandler.getUser(userToken: Variables.UserToken) { user in
                        dataHandler.getCourses() { success in  }
                            
                        
                        
                        dataHandler.getCards() { success in
                            Variables.ShowOnbordingAtStart = true
                            self.dismiss(animated: false, completion: nil)
                            
                            
                            //DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadProfile"), object: nil)
                            //}
                            
                            AppDelegate.instance().dismissActivityIndicator()
                            if( Variables.userIsTeamster == true) {
                                dataHandler.getTeamInvites(teamId: (Variables.Teams[Variables.Teams.count-1].id))
                            }
                            
                            dataHandler.orderFindYourFlowStates() { success in }
                        }
                            
                       
                        dataHandler.getAllUsers()
                    }
                    
                }
            }
        }
    }
    
}
