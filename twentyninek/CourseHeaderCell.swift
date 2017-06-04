//
//  CourseHeaderCell.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class CourseHeaderCell: BaseCollectionCell {
    
    let datahandler = DataHandler()
    
    let headerContainterView: UIView = {
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
    
    let headerContentContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let courseHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Course outline"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var completedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0/0"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 38, weight: UIFontWeightSemibold)
        label.textAlignment = .center
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        return view
    }()
    
    let completedLabel: UILabel = {
        let label = UILabel()
        label.text = "completed modules"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        setupHeader()
    }
    
    fileprivate func setupHeader() {
        
        contentView.addSubview(self.headerContainterView)
        headerContainterView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerContainterView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        headerContainterView.addSubview(headerImage)
        headerImage.anchor(top: headerContainterView.topAnchor, left: headerContainterView.leftAnchor, bottom: nil, right: headerContainterView.rightAnchor, paddingTop: -64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        headerContainterView.insertSubview(headerContentContainerView, at: 2)
        headerContentContainerView.anchor(top: headerContainterView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 38, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 100)
        headerContentContainerView.centerXAnchor.constraint(equalTo: headerContainterView.centerXAnchor).isActive = true
        
        headerContentContainerView.addSubview(courseHeaderLabel)
        courseHeaderLabel.anchor(top: headerContentContainerView.topAnchor, left: headerContentContainerView.leftAnchor, bottom: nil, right: headerContentContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        headerContentContainerView.addSubview(completedValueLabel)
        completedValueLabel.anchor(top: courseHeaderLabel.bottomAnchor, left: headerContentContainerView.leftAnchor, bottom: nil, right: headerContentContainerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        completedValueLabel.text = "\(Variables.CoursesCompleted)/\(Variables.CoursesCount)"
        
        headerContentContainerView.addSubview(lineView)
        lineView.anchor(top: completedValueLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 55, height: 2)
        lineView.centerXAnchor.constraint(equalTo: headerContentContainerView.centerXAnchor).isActive = true
        
        
        headerContentContainerView.addSubview(completedLabel)
        completedLabel.anchor(top: lineView.bottomAnchor, left: headerContentContainerView.leftAnchor, bottom: nil, right: headerContentContainerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        completedLabel.centerXAnchor.constraint(equalTo: headerContentContainerView.centerXAnchor).isActive = true
    }
    
}

