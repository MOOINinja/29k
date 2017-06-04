//
//  CourseCellLocked.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class CourseCellLocked: BaseCollectionCell {
    
    let rightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        btn.setImage(UIImage(named: "locked")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        btn.clipsToBounds = true
        return btn
    }()
    
    let leftContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let courseTitle: UILabel = {
        let label = UILabel()
        label.text = "FIND YOUR FLOW"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        label.textColor = UIColor.rgb(red: 120, green: 120, blue: 120, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    let courseDescription: UILabel = {
        let label = UILabel()
        label.text = "Log your actions to understand what you like"
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        label.textColor = UIColor.rgb(red: 147, green: 147, blue: 147, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        setupCellContents()
        
    }
    
    func setupCellContents() {
        addSubview(leftContainer)
        addSubview(rightContainer)
        
        leftContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width / 2, height: 0)
        
        leftContainer.addSubview(courseTitle)
        courseTitle.anchor(top: leftContainer.topAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        leftContainer.addSubview(courseDescription)
        courseDescription.anchor(top: courseTitle.bottomAnchor, left: leftContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        rightContainer.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width / 2, height: 0)
        
        rightContainer.addSubview(button)
        button.anchor(top: nil, left: nil, bottom: nil, right: rightContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -16, width: 42, height: 42)
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
