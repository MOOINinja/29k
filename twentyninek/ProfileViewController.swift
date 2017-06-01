//
//  ViewController.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-05-29.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let headerCellID = "headerCellID"
    let cellID = "cellID"
    let startWithWhyCellID = "startWithWhyCellID"
    let findYourFlowCellID = "findYourFlowCellID"
    
    var points = [0,0,0,0]
    //var assets: [Any] = []
    var assets = ["life scan", "start with why", "find your flow"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        registerCell()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func registerCell() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(ProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! ProfileHeaderCell
        if (Variables.CurrentUser != nil) {
            header.profileImage.image = (Variables.CurrentUser?.Image.image)!
            let firstName = Variables.CurrentUser?.FirstName
            header.usernameLabel.text = firstName
            
            let age = Variables.CurrentUser?.Age ?? ""
            header.ageLabel.text = "\(String(describing: age)) years"
            
            let occupation = Variables.CurrentUser?.Occupation ?? ""
            var school = Variables.CurrentUser?.School ?? ""
            let location = Variables.CurrentUser?.Location ?? ""
            
            if ( school != "" && occupation != "") {
                school = ", \(school)"
            }
            
            header.informationLabel.text = "\(occupation)\(school)" //, \(location)"
            
            header.completedValueLabel.text = "\(Variables.CoursesCompleted)/\(Variables.CoursesCount)"
        }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    //Assets
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 300)
        }
        return CGSize(width: view.frame.width, height: 250)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}

