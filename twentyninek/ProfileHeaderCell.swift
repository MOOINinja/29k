//
//  ProfileHeaderCell.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class ProfileHeaderCell: BaseCollectionCell {
    
    let datahandler = DataHandler()
    
    lazy var headerContainterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        return view
    }()
    
    let headerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Profile_Bg")?.withRenderingMode(.alwaysOriginal)
        return image
    }()
    
    lazy var leftHeaderContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.lightGray
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var rightHeaderContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // = =
    var profileImage: UIImageView = {
        var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imgView.backgroundColor = UIColor.lightGray
        imgView.layer.cornerRadius = 50
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let profileFrame: UIView = {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.45
        outerView.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        outerView.layer.shadowRadius = 1
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 50).cgPath
        return outerView
    }()
    // = =
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Some more information"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let completedIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "completed_modules_icon")?.withRenderingMode(.alwaysOriginal)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let completedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "1/7"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var completedLabel: UILabel = {
        let label = UILabel()
        label.text = "completed modules"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    lazy var editButton: UIButton = {
        let img = UIButton()
        img.isEnabled = true
        img.isUserInteractionEnabled = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tag = 11
        img.setImage(UIImage(named: "edit_icon"), for: .normal)
        return img
    }()
    
    func test() {
        print("\n\n TEST \n\n")
    }
    
    let rewardIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "reward_icon")?.withRenderingMode(.alwaysOriginal)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let rewardLabel: UILabel = {
        let label = UILabel()
        label.text = "rewards"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let rewardValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        setupHeader()
    }
    
    func openCourse(){
        let tababarController = self.window!.rootViewController as! UITabBarController
        tababarController.selectedIndex = 1
    }
    
    func setupHeader() {
        
        contentView.addSubview(self.headerContainterView)
        headerContainterView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerContainterView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        headerContainterView.insertSubview(headerImage, at: 2)
        headerImage.anchor(top: headerContainterView.topAnchor, left: headerContainterView.leftAnchor, bottom: nil, right: headerContainterView.rightAnchor, paddingTop: -64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        headerContainterView.insertSubview(profileImage, at: 6)
        profileImage.anchor(top: headerContainterView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        headerContainterView.insertSubview(profileFrame, at: 2)
        profileFrame.anchor(top: headerContainterView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileFrame.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        profileFrame.addSubview(profileImage)
        profileImage.anchor(top: headerContainterView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        headerContainterView.addSubview(leftHeaderContainerView)
        leftHeaderContainerView.anchor(top: profileImage.topAnchor, left: nil, bottom: nil, right: self.profileImage.leftAnchor, paddingTop: 22, paddingLeft: 0, paddingBottom: 0, paddingRight: -78, width: 0, height: 0)
        
        // ******
        leftHeaderContainerView.backgroundColor = UIColor.red
        let tapOpenCourse = UITapGestureRecognizer(target: self, action: #selector(openCourse))
        leftHeaderContainerView.addGestureRecognizer(tapOpenCourse)
        
        
        leftHeaderContainerView.addSubview(completedIcon)
        completedIcon.anchor(top: self.leftHeaderContainerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        completedIcon.centerXAnchor.constraint(equalTo: self.leftHeaderContainerView.centerXAnchor).isActive = true
        
        leftHeaderContainerView.addSubview(completedValueLabel)
        completedValueLabel.anchor(top: completedIcon.topAnchor, left: completedIcon.rightAnchor, bottom: self.completedIcon.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 4, paddingBottom: 1, paddingRight: 0, width: 0, height: 0)
        
        headerContainterView.addSubview(rightHeaderContainerView)
        rightHeaderContainerView.anchor(top: profileImage.topAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, paddingTop: 22, paddingLeft: 66, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(editButton)
        editButton.anchor(top: rightHeaderContainerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        editButton.centerXAnchor.constraint(equalTo: rightHeaderContainerView.centerXAnchor).isActive = true
        
        headerContainterView.addSubview(self.usernameLabel)
        usernameLabel.anchor(top: self.profileImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 20)
        self.usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        self.headerContainterView.addSubview(self.ageLabel)
        self.ageLabel.anchor(top: self.usernameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 16)
        self.ageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.headerContainterView.addSubview(self.informationLabel)
        self.informationLabel.anchor(top: self.ageLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 16)
        self.informationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
}
