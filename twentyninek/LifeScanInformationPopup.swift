//
//  LifeScanInformationPopup.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

struct Slide {
    let text: String?
}

class LifeScanInformationPopup: UIView, UIScrollViewDelegate {
    
    let popupView: UIView = {
        let view = UIView()
        let width = UIScreen.main.bounds.width
        let height =  UIScreen.main.bounds.height
        view.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        //view.backgroundColor = UIColor.red
        view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        view.isHidden = true
        //view.layer.cornerRadius = 6
        return view
    }()
    
    let coverPopUp: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        let width = UIScreen.main.bounds.width
        let height =  UIScreen.main.bounds.height
        view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        view.isHidden = true
        return view
    }()
    
    let headerImage: UIImageView = {
        let header = UIImageView()
        header.image = UIImage(named: "popupheader_default")?.withRenderingMode(.alwaysOriginal)
        header.contentMode = .scaleAspectFill
        return header
    }()
    
    let contentContainer: UIView = {
        let container = UIView()
        //container.clipsToBounds = false
        //container.layer.masksToBounds = false
        container.backgroundColor = UIColor.cyan
        return container
    }()
    /*
     let headerLabel: UILabel = {
     let label = UILabel()
     label.text = "Module description"
     label.textColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
     label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
     label.textAlignment = .center
     return label
     }()
     */
    let icon: UIImageView = {
        let view = UIImageView()
        //view.image = UIImage(named: "workInfoPop")?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240, alpha: 1)
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Module description"
        label.textColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let moduleLabel: UILabel = {
        let label = UILabel()
        label.text = "Life Scan"
        label.textColor = UIColor.rgb(red: 124, green: 108, blue: 199, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let infoLabel: UITextView = {
        let label = UITextView()
        label.text = "Reflect on where you are now in order to get insight on where to go next."
        label.textColor = UIColor.rgb(red: 100, green: 100, blue: 100, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        label.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        label.textAlignment = .center
        label.isEditable = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "VideoPlaceHolder")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let buttonOkay: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1), for: .normal)
        button.backgroundColor = UIColor.rgb(red: 124, green: 108, blue: 199, alpha: 1)
        button.layer.cornerRadius = 18
        button.isUserInteractionEnabled = true
        return button
    }()
    
    //Scroll & paging
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    var scrollWidth : CGFloat = UIScreen.main.bounds.size.width
    var scrollHeight : CGFloat = 200
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.rgb(red: 124, green: 108, blue: 199, alpha: 0.5)
        pc.currentPageIndicatorTintColor = UIColor.rgb(red: 124, green: 108, blue: 199, alpha: 1)
        pc.numberOfPages = 2
        return pc
    }()
    
    //
    let pageOneImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "LifeScanPageOne")?.withRenderingMode(.alwaysOriginal)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let pageTwoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "LifeScanPageTwo")?.withRenderingMode(.alwaysOriginal)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContent()
        
        
        print((scrollView.frame.size.width))
        scrollView.contentSize = CGSize(width: (scrollWidth * 2), height: scrollHeight)
        scrollView.delegate = self
        scrollView.isPagingEnabled=true
        
        for i in 0...2 {
            let imgView = UIImageView.init()
            imgView.frame = CGRect(x: scrollWidth * CGFloat (i), y: 0, width: scrollWidth,height: scrollHeight)
            if i == 0 {
                imgView.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
                imgView.addSubview(pageOneImage)
                pageOneImage.anchor(top: imgView.topAnchor, left: nil, bottom: imgView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 240, height: 0)
                pageOneImage.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
                
                
            }
            
            if i == 1 {
                imgView.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
                imgView.addSubview(pageTwoImage)
                pageTwoImage.anchor(top: imgView.topAnchor, left: nil, bottom: imgView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 240, height: 0)
                pageTwoImage.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
            }
            
            scrollView.addSubview(imgView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let modulePage = Int(targetContentOffset.pointee.x / popupView.frame.width)
        pageControl.currentPage = modulePage
        
        Variables.currentPageIndex = pageControl.currentPage
        
    }
    
    
    
    func setupContent() {
        insertSubview(coverPopUp, at: 1)
        coverPopUp.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 16).isActive = true
        coverPopUp.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 16).isActive = true
        
        coverPopUp.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        insertSubview(popupView, at: 5)
        popupView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 16).isActive = true
        popupView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 16).isActive = true
        
        popupView.addSubview(headerImage)
        headerImage.anchor(top: popupView.topAnchor, left: popupView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        /*
         headerImage.addSubview(headerLabel)
         headerLabel.anchor(top: headerImage.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 20)
         headerLabel.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
         */
        headerImage.addSubview(headerLabel)
        headerLabel.anchor(top: headerImage.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        headerLabel.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
        /*
         headerImage.addSubview(icon)
         icon.anchor(top: headerLabel.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
         icon.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
         */
        popupView.addSubview(moduleLabel)
        moduleLabel.anchor(top: headerImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        moduleLabel.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
        
        popupView.addSubview(infoLabel)
        infoLabel.anchor(top: moduleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 100)
        infoLabel.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
        
        
        
        popupView.addSubview(buttonOkay)
        buttonOkay.anchor(top: nil, left:headerImage.leftAnchor, bottom: popupView.bottomAnchor, right: headerImage.rightAnchor, paddingTop: 0, paddingLeft:16, paddingBottom: 10, paddingRight: -16, width: 0, height: 48)
        buttonOkay.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
        /*
         popupView.addSubview(infoImage)
         infoImage.anchor(top: nil, left: headerImage.leftAnchor, bottom: buttonOkay.topAnchor, right: headerImage.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 55, paddingRight: -25, width: 0, height: 105)
         infoImage.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
         */
        popupView.addSubview(pageControl)
        pageControl.anchor(top: nil, left: nil, bottom: buttonOkay.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom:60, paddingRight: 0, width: 1, height: 1)
        pageControl.centerXAnchor.constraint(equalTo: headerImage.centerXAnchor).isActive = true
        
        popupView.addSubview(scrollView)
        scrollView.anchor(top: nil, left: headerImage.leftAnchor, bottom: buttonOkay.topAnchor, right: headerImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 270)
        
    }
    
    
}

class SlideView: UIView {
    
    var slide: Slide? {
        didSet{
            guard let slide = slide else {return}
            
            guard let slideText = slide.text else {return}
            textView.text = slideText
            
            
        }
    }
    
    let textView: UITextView = {
        let view = UITextView()
        view.text = "test text"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.brown
        
        addSubview(textView)
        textView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, width: 0, height: 200)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
