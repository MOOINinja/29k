//
//  CourseTeamSessionDefaultCell.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class CourseTeamSessionDefaultCell: BaseCollectionCell {
    
    let rightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let peopleAttending: UILabel = {
        let label = UILabel()
        label.text = "Attending (0)"
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        label.textColor = UIColor.rgb(red: 147, green: 147, blue: 147, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.rgb(red: 98, green: 81, blue: 186, alpha: 1)
        btn.setTitle("Schedule", for: .normal)
        btn.setTitleColor(UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular)
        btn.layer.cornerRadius = 4
        return btn
    }()
    
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
        
        leftContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width / 2, height: 0)
        
        leftContainer.addSubview(courseTitle)
        courseTitle.anchor(top: leftContainer.topAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        leftContainer.addSubview(teamSessionDate)
        teamSessionDate.anchor(top: courseTitle.bottomAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        leftContainer.addSubview(teamSessionLocation)
        teamSessionLocation.anchor(top: teamSessionDate.bottomAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        rightContainer.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width / 2, height: 0)
        
        rightContainer.addSubview(peopleAttending)
        peopleAttending.anchor(top: rightContainer.topAnchor, left: nil, bottom: nil, right: rightContainer.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: -8, width: 90, height: 0)
        
        addSubview(button)
        button.anchor(top: peopleAttending.bottomAnchor, left: nil, bottom: nil, right: rightContainer.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: -16, width: 74, height: 30)
    }
}
