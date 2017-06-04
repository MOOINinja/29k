//
//  CourseTeamSessionScheduledCell.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class CourseTeamSessionScheduledCell: BaseCollectionCell {
    
    let rightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let disclosureContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var disclosureIcon: UIImageView = {
        var imgView = UIImageView()
        imgView.image = UIImage(named: "disclosure_icon")?.withRenderingMode(.alwaysOriginal)
        return imgView
    }()
    
    
    let peopleAttending: UILabel = {
        let label = UILabel()
        label.text = "Attending (1)"
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        label.textColor = UIColor.rgb(red: 147, green: 147, blue: 147, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    // = =
    var profileImage: UIImageView = {
        var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imgView.backgroundColor = UIColor.lightGray
        imgView.layer.cornerRadius = 20
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let profileFrame: UIView = {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.45
        outerView.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        outerView.layer.shadowRadius = 1
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 20).cgPath
        return outerView
    }()
    // = =
    
    let leftContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let courseTitle: UILabel = {
        let label = UILabel()
        label.text = "Team session"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.textColor = UIColor.rgb(red: 120, green: 120, blue: 120, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let teamSessionDate: UILabel = {
        let label = UILabel()
        label.text = "April 26, kl 14.30"
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        label.textColor = UIColor.rgb(red: 147, green: 147, blue: 147, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let teamSessionLocation: UILabel = {
        let label = UILabel()
        label.text = "Espessohouse, Sveavägen 17"
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        label.textColor = UIColor.rgb(red: 147, green: 147, blue: 147, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 237, alpha: 1)
        setupCellContents()
        
    }
    
    func setupCellContents() {
        addSubview(leftContainer)
        addSubview(rightContainer)
        addSubview(disclosureContainer)
        
        leftContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width / 2, height: 0)
        
        leftContainer.addSubview(courseTitle)
        courseTitle.anchor(top: leftContainer.topAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        leftContainer.addSubview(teamSessionDate)
        teamSessionDate.anchor(top: courseTitle.bottomAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        leftContainer.addSubview(teamSessionLocation)
        teamSessionLocation.anchor(top: teamSessionDate.bottomAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        disclosureContainer.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 0)
        
        disclosureContainer.addSubview(disclosureIcon)
        disclosureIcon.anchor(top: nil, left: nil, bottom: nil, right: disclosureContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -8, width: 0, height: 0)
        disclosureIcon.centerYAnchor.constraint(equalTo: disclosureContainer.centerYAnchor).isActive = true
        
        rightContainer.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: disclosureContainer.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width / 3, height: 0)
        
        rightContainer.addSubview(peopleAttending)
        peopleAttending.anchor(top: rightContainer.topAnchor, left: nil, bottom: nil, right: rightContainer.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: -8, width: 90, height:14)
        
        rightContainer.addSubview(profileFrame)
        profileFrame.anchor(top: peopleAttending.bottomAnchor, left: nil, bottom: nil, right: rightContainer.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 6, paddingRight: -16, width: 40, height: 40)
        profileFrame.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        profileFrame.addSubview(profileImage)
        profileImage.anchor(top: peopleAttending.bottomAnchor, left: nil, bottom: nil, right: rightContainer.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 6, paddingRight: -16, width: 40, height: 40)
    }
}
