//
//  CourseOutlineViewController.swift
//  twentyninek
//
//  Created by Chibi Anward on 2017-06-01.
//  Copyright © 2017 29k. All rights reserved.
//

import UIKit

class CourseOutlineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let headerCellID = "headerCellID"
    let cellID = "cellID"
    
    let courseTeamSessionDefaultCellID = "courseTeamSessionDefaultCellID"
    let courseTeamSessionScheduledCellID = "courseTeamSessionScheduledCellID"
    
    let lifeScanStartCellID = "lifeScanStartCellID"
    let lifeScanOngoingCellID = "lifeScanOngoingCellID"
    let lifeScanDoneCellID = "lifeScanDoneCellID"
    let lifeScanLockedCellID = "lifeScanLockedCellID"
    
    let startWithWhyStartCellID = "startWithWhyStartCellID"
    let startWithWhyOngoingCellID = "startWithWhyOngoingCellID"
    let startWithWhyDoneCellID = "startWithWhyDoneCellID"
    let startWithWhyLockedCellID = "startWithWhyLockedCellID"
    
    let findYourFlowStartCellID = "findYourFlowStartCellID"
    let findYourFlowOngoingCellID = "findYourFlowOngoingCellID"
    let findYourFlowDoneCellID = "findYourFlowDoneCellID"
    let findYourFlowLockedCellID = "findYourFlowLockedCellID"
    
    let designYourLifeStartCellID = "designYourLifeStartCellID"
    let designYourLifeOngoingCellID = "designYourLifeOngoingCellID"
    let designYourLifeDoneCellID = "designYourLifeDoneCellID"
    let designYourLifeLockedCellID = "designYourLifeLockedCellID"
    
    let prototypeYourLifeStartCellID = "prototypeYourLifeStartCellID"
    let prototypeYourLifeOngoingCellID = "prototypeYourLifeOngoingCellID"
    let prototypeYourLifeDoneCellID = "prototypeYourLifeDoneCellID"
    let prototypeYourLifeLockedCellID = "prototypeYourLifeLockedCellID"
    
    let chooseCareerStartCellID = "chooseCareerStartCellID"
    let chooseCareerOngoingCellID = "chooseCareerOngoingCellID"
    let chooseCareerDoneCellID = "chooseCareerDoneCellID"
    let chooseCareerLockedCellID = "chooseCareerLockedCellID"
    
    var courseList = [MyCourses.start, MyCourses.locked, MyCourses.locked, MyCourses.teamSessionScheduled, MyCourses.locked,  MyCourses.locked, MyCourses.locked]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246, alpha: 1)
        return cv
    }()
    
    let window = UIApplication.shared.keyWindow
    let lifeScanPopup = LifeScanInformationPopup()
    let startWithWhyPopup = StartWithWhyInformationPopup()
    let findYourFlowPopup = FindYourFlowInformationPopup()
    let designYourLifePopup = DesignYourLifePopup()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Courses"
        
        registerCell()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //LifeScan
        window?.insertSubview(lifeScanPopup.popupView, at: 7)
        lifeScanPopup.buttonOkay.addTarget(self, action: #selector(closeLifeScanPopup), for: .touchDown)
        
        //StartWithWhy
        window?.insertSubview(startWithWhyPopup.popupView, at: 7)
        startWithWhyPopup.buttonOkay.addTarget(self, action: #selector(closeStartWithWhyPopup), for: .touchDown)
        
        //StartWithWhy
        window?.insertSubview(findYourFlowPopup.popupView, at: 7)
        findYourFlowPopup.buttonOkay.addTarget(self, action: #selector(closeFindYourFlowPopup), for: .touchDown)
        
        //DesignYourLife
        window?.insertSubview(designYourLifePopup.popupView, at: 7)
        designYourLifePopup.buttonOkay.addTarget(self, action: #selector(closeDesignYourLifePopup), for: .touchDown)
        
        window?.insertSubview(blurEffectView, at: 1)
        blurEffectView.frame = (window?.frame)!
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //LifeScanPopup
    func lifeScanPopupAction() {
        UIView.animate(withDuration: 1.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = false
            self.lifeScanPopup.popupView.isHidden = false
            self.lifeScanPopup.popupView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            print("animation finished")
        }
    }
    
    func closeLifeScanPopup() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = true
            self.lifeScanPopup.popupView.isHidden = true
            self.lifeScanPopup.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
        }) { (finished: Bool) in
        }
    }
    
    //StartWithWhyPopup
    func startWithWhyPopupAction() {
        UIView.animate(withDuration: 1.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = false
            self.startWithWhyPopup.popupView.isHidden = false
            self.startWithWhyPopup.popupView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            print("animation finished")
        }
    }
    
    func closeStartWithWhyPopup() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = true
            self.startWithWhyPopup.popupView.isHidden = true
            self.startWithWhyPopup.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
        }) { (finished: Bool) in
        }
    }
    
    //FindYourFlowPopup
    func findYourFlowPopupAction() {
        UIView.animate(withDuration: 1.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = false
            self.findYourFlowPopup.popupView.isHidden = false
            self.findYourFlowPopup.popupView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            print("animation finished")
        }
    }
    
    func closeFindYourFlowPopup() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = true
            self.findYourFlowPopup.popupView.isHidden = true
            self.findYourFlowPopup.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
        }) { (finished: Bool) in
        }
    }
    
    //DesignYourFlowPopup
    func designYourLifePopupAction() {
        UIView.animate(withDuration: 1.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = false
            self.designYourLifePopup.popupView.isHidden = false
            self.designYourLifePopup.popupView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            print("animation finished")
        }
    }
    
    func closeDesignYourLifePopup() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.blurEffectView.isHidden = true
            self.designYourLifePopup.popupView.isHidden = true
            self.designYourLifePopup.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
        }) { (finished: Bool) in
        }
    }
   
    //Intro
    func continueToLifeScanIntro() {
        print("continueToLifeScanIntro")
    }
    
    func continueToStartWithWhyIntro() {
       /*
        let startCourse = LifePhilosophyInstructionViewController()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        let navController = UINavigationController(rootViewController: startCourse)
        self.navigationController?.present(navController, animated: false, completion: nil)
 */
    }
    
    func continueToFindYourFlowIntro() {
        /*
        let startCourse = FindYourFlowInstructionViewController()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        let navController = UINavigationController(rootViewController: startCourse)
        self.navigationController?.present(navController, animated: false, completion: nil)
 */
    }
    
    //Summary
    func lifeScanSummary() {
        /*
        let startCourse = LifeScanSummaryViewController()
        startCourse.setupNavButtons()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        let navController = UINavigationController(rootViewController: startCourse)
        self.navigationController?.present(navController, animated: false, completion: nil)
 */
    }
    
    func startWithWhySummary() {
        /*
        let startCourse = StartWithWhySummaryViewController()
        startCourse.setupNavButtons()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        let navController = UINavigationController(rootViewController: startCourse)
        self.navigationController?.present(navController, animated: false, completion: nil)
 */
    }
    
    func findYourFlowSummary() {
        print("findYourFlowSummary")
    }
    
    func registerCell() {
        collectionView.register(CourseTeamSessionDefaultCell.self, forCellWithReuseIdentifier: courseTeamSessionDefaultCellID)
        collectionView.register(CourseTeamSessionScheduledCell.self, forCellWithReuseIdentifier: courseTeamSessionScheduledCellID)
        collectionView.register(CourseHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
        
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: lifeScanStartCellID)
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: lifeScanOngoingCellID)
        collectionView.register(CourseCellDone.self, forCellWithReuseIdentifier: lifeScanDoneCellID)
        collectionView.register(CourseCellLocked.self, forCellWithReuseIdentifier: lifeScanLockedCellID)
        
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: startWithWhyStartCellID)
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: startWithWhyOngoingCellID)
        collectionView.register(CourseCellDone.self, forCellWithReuseIdentifier: startWithWhyDoneCellID)
        collectionView.register(CourseCellLocked.self, forCellWithReuseIdentifier: startWithWhyLockedCellID)
        
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: findYourFlowStartCellID)
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: findYourFlowOngoingCellID)
        collectionView.register(CourseCellDone.self, forCellWithReuseIdentifier: findYourFlowDoneCellID)
        collectionView.register(CourseCellLocked.self, forCellWithReuseIdentifier: findYourFlowLockedCellID)
        
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: designYourLifeStartCellID)
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: designYourLifeOngoingCellID)
        collectionView.register(CourseCellDone.self, forCellWithReuseIdentifier: designYourLifeDoneCellID)
        collectionView.register(CourseCellLocked.self, forCellWithReuseIdentifier: designYourLifeLockedCellID)
        
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: prototypeYourLifeStartCellID)
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: prototypeYourLifeOngoingCellID)
        collectionView.register(CourseCellDone.self, forCellWithReuseIdentifier: prototypeYourLifeDoneCellID)
        collectionView.register(CourseCellLocked.self, forCellWithReuseIdentifier: prototypeYourLifeLockedCellID)
        
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: chooseCareerStartCellID)
        collectionView.register(CourseCellStart.self, forCellWithReuseIdentifier: chooseCareerOngoingCellID)
        collectionView.register(CourseCellDone.self, forCellWithReuseIdentifier: chooseCareerDoneCellID)
        collectionView.register(CourseCellLocked.self, forCellWithReuseIdentifier: chooseCareerLockedCellID)
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! CourseHeaderCell
        header.completedValueLabel.text = "\(Variables.CoursesCompleted)/\(Variables.CoursesCount)"
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    //Modules
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let selectedModule = courseList[indexPath.item]
        
        // Life Scan
        if( indexPath.item == 0 ) {
            if selectedModule == MyCourses.ongoing {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: lifeScanOngoingCellID, for: indexPath) as! CourseCellStart
                
                cellStart.button.setImage(UIImage(named: "doingCourseIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                cellStart.courseTitle.text = "LIFE SCAN"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.start {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: lifeScanStartCellID, for: indexPath) as! CourseCellStart
                cellStart.courseTitle.text = "LIFE SCAN"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.done {
                let cellDone = collectionView.dequeueReusableCell(withReuseIdentifier: lifeScanDoneCellID, for: indexPath) as! CourseCellDone
                cellDone.courseTitle.text = "LIFE SCAN"
                cellDone.courseDescription.text = "Self assessment of where you are in life"
                // TO sumnmary
            //    cellDone.button.addTarget(self, action: #selector(lifeScanSummary), for: .touchUpInside)
                return cellDone
                
            } else if selectedModule == MyCourses.locked {
                let cellLocked = collectionView.dequeueReusableCell(withReuseIdentifier: lifeScanLockedCellID, for: indexPath) as! CourseCellLocked
                cellLocked.courseTitle.text = "LIFE SCAN"
                cellLocked.courseDescription.text = "Self assessment of where you are in life"
                return cellLocked
                
            } else if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                return cellteamSessionScheduled
            }
            
        }
        
        // Start With Why
        if( indexPath.item == 1 ) {
            if selectedModule == MyCourses.ongoing {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: startWithWhyOngoingCellID, for: indexPath) as! CourseCellStart
                cellStart.button.setImage(UIImage(named: "doingCourseIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
            //    cellStart.button.addTarget(self, action: #selector(continueToStartWithWhyIntro), for: .touchUpInside)
                cellStart.courseTitle.text = "START WITH WHY"
                cellStart.courseDescription.text = "Understanding your values"
                return cellStart
                
            } else if selectedModule == MyCourses.start {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: startWithWhyStartCellID, for: indexPath) as! CourseCellStart
             //   cellStart.button.addTarget(self, action: #selector(continueToStartWithWhyIntro), for: .touchUpInside)
                cellStart.courseTitle.text = "START WITH WHY"
                cellStart.courseDescription.text = "Understanding your values"
                return cellStart
                
            } else if selectedModule == MyCourses.done {
                let cellDone = collectionView.dequeueReusableCell(withReuseIdentifier: startWithWhyDoneCellID, for: indexPath) as! CourseCellDone
             //   cellDone.button.addTarget(self, action: #selector(startWithWhySummary), for: .touchUpInside)
                cellDone.courseTitle.text = "START WITH WHY"
                cellDone.courseDescription.text = "Understanding your values"
                return cellDone
                
            } else if selectedModule == MyCourses.locked {
                let cellLocked = collectionView.dequeueReusableCell(withReuseIdentifier: startWithWhyLockedCellID, for: indexPath) as! CourseCellLocked
                cellLocked.courseTitle.text = "START WITH WHY"
                cellLocked.courseDescription.text = "Understanding your values"
                return cellLocked
                
            } else if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                return cellteamSessionScheduled
            }
            
        }
        
        // Find Your Flow
        if( indexPath.item == 2 ) {
            if selectedModule == MyCourses.ongoing {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: findYourFlowOngoingCellID, for: indexPath) as! CourseCellStart
                
                cellStart.button.setImage(UIImage(named: "doingCourseIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                // TO start
              // cellStart.button.addTarget(self, action: #selector(continueToFindYourFlowIntro), for: .touchUpInside)
                cellStart.courseTitle.text = "FIND YOUR FLOW"
                cellStart.courseDescription.text = "Log your actions to understand what you like"
                
                return cellStart
                
            } else if selectedModule == MyCourses.start {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: findYourFlowStartCellID, for: indexPath) as! CourseCellStart
                // TO start
            // cellStart.button.addTarget(self, action: #selector(continueToFindYourFlowIntro), for: .touchDown)
                cellStart.courseTitle.text = "FIND YOUR FLOW"
                cellStart.courseDescription.text = "Log your actions to understand what you like"
                return cellStart
                
            } else if selectedModule == MyCourses.done {
                let cellDone = collectionView.dequeueReusableCell(withReuseIdentifier: findYourFlowDoneCellID, for: indexPath) as! CourseCellDone
                // TO sumnmary
                //cellDone.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                cellDone.courseTitle.text = "FIND YOUR FLOW"
                cellDone.courseDescription.text = "Log your actions to understand what you like"
                return cellDone
                
            } else if selectedModule == MyCourses.locked {
                let cellLocked = collectionView.dequeueReusableCell(withReuseIdentifier: findYourFlowLockedCellID, for: indexPath) as! CourseCellLocked
                cellLocked.courseTitle.text = "FIND YOUR FLOW"
                cellLocked.courseDescription.text = "Log your actions to understand what you like"
                return cellLocked
                
            } else if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                return cellteamSessionScheduled
            }
        }
        
        // Design you life
        if( indexPath.item == 4 ) {
            if selectedModule == MyCourses.ongoing {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: designYourLifeOngoingCellID, for: indexPath) as! CourseCellStart
                
                cellStart.button.setImage(UIImage(named: "doingCourseIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                cellStart.courseTitle.text = "DESIGN Your LIFE"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.start {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: designYourLifeStartCellID, for: indexPath) as! CourseCellStart
                cellStart.courseTitle.text = "DESIGN Your LIFE"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.done {
                let cellDone = collectionView.dequeueReusableCell(withReuseIdentifier: designYourLifeDoneCellID, for: indexPath) as! CourseCellDone
                cellDone.courseTitle.text = "DESIGN Your LIFE"
                cellDone.courseDescription.text = "Self assessment of where you are in life"
                // TO sumnmary
                //    cellDone.button.addTarget(self, action: #selector(lifeScanSummary), for: .touchUpInside)
                return cellDone
                
            } else if selectedModule == MyCourses.locked {
                let cellLocked = collectionView.dequeueReusableCell(withReuseIdentifier: designYourLifeLockedCellID, for: indexPath) as! CourseCellLocked
                cellLocked.courseTitle.text = "DESIGN Your LIFE"
                cellLocked.courseDescription.text = "Self assessment of where you are in life"
                return cellLocked
                
            } else if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                return cellteamSessionScheduled
            }
        }
        
        // Prototype your life
        if( indexPath.item == 5 ) {
            if selectedModule == MyCourses.ongoing {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: prototypeYourLifeOngoingCellID, for: indexPath) as! CourseCellStart
                
                cellStart.button.setImage(UIImage(named: "doingCourseIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                cellStart.courseTitle.text = "PROTOTYPE YOUR LIFE"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.start {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: prototypeYourLifeStartCellID, for: indexPath) as! CourseCellStart
                cellStart.courseTitle.text = "PROTOTYPE YOUR LIFE"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.done {
                let cellDone = collectionView.dequeueReusableCell(withReuseIdentifier: prototypeYourLifeDoneCellID, for: indexPath) as! CourseCellDone
                cellDone.courseTitle.text = "PROTOTYPE YOUR LIFE"
                cellDone.courseDescription.text = "Self assessment of where you are in life"
                // TO sumnmary
                //    cellDone.button.addTarget(self, action: #selector(lifeScanSummary), for: .touchUpInside)
                return cellDone
                
            } else if selectedModule == MyCourses.locked {
                let cellLocked = collectionView.dequeueReusableCell(withReuseIdentifier: prototypeYourLifeLockedCellID, for: indexPath) as! CourseCellLocked
                cellLocked.courseTitle.text = "PROTOTYPE YOUR LIFE"
                cellLocked.courseDescription.text = "Self assessment of where you are in life"
                return cellLocked
                
            } else if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                return cellteamSessionScheduled
            }
            
        }
        
        // Choose Career
        if( indexPath.item == 6 ) {
            if selectedModule == MyCourses.ongoing {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: chooseCareerOngoingCellID, for: indexPath) as! CourseCellStart
                
                cellStart.button.setImage(UIImage(named: "doingCourseIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                cellStart.courseTitle.text = "CHOOSE CAREER"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.start {
                let cellStart = collectionView.dequeueReusableCell(withReuseIdentifier: chooseCareerStartCellID, for: indexPath) as! CourseCellStart
                cellStart.courseTitle.text = "CHOOSE CAREER"
                cellStart.courseDescription.text = "Self assessment of where you are in life"
                // TO start
                //cellStart.button.addTarget(self, action: #selector(continueToCourseIntro), for: .touchUpInside)
                
                return cellStart
                
            } else if selectedModule == MyCourses.done {
                let cellDone = collectionView.dequeueReusableCell(withReuseIdentifier: chooseCareerDoneCellID, for: indexPath) as! CourseCellDone
                cellDone.courseTitle.text = "CHOOSE CAREER"
                cellDone.courseDescription.text = "Self assessment of where you are in life"
                // TO sumnmary
                //    cellDone.button.addTarget(self, action: #selector(lifeScanSummary), for: .touchUpInside)
                return cellDone
                
            } else if selectedModule == MyCourses.locked {
                let cellLocked = collectionView.dequeueReusableCell(withReuseIdentifier: chooseCareerLockedCellID, for: indexPath) as! CourseCellLocked
                cellLocked.courseTitle.text = "CHOOSE CAREER"
                cellLocked.courseDescription.text = "Self assessment of where you are in life"
                return cellLocked
                
            } else if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                return cellteamSessionScheduled
            }
            
        }
        
        if( indexPath.item == 3 ) {
            if selectedModule == MyCourses.teamSessionDefault {
                let cellteamSessionDefault = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionDefaultCellID, for: indexPath) as! CourseTeamSessionDefaultCell
                return cellteamSessionDefault
                
            } else if selectedModule == MyCourses.teamSessionScheduled {
                let cellteamSessionScheduled = collectionView.dequeueReusableCell(withReuseIdentifier: courseTeamSessionScheduledCellID, for: indexPath) as! CourseTeamSessionScheduledCell
                cellteamSessionScheduled.profileImage.image = (Variables.CurrentUser?.Image.image)!
                return cellteamSessionScheduled
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 3)  {
            return CGSize(width: collectionView.frame.width, height: 80)
        } else {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("Life Scan")
         lifeScanPopupAction()
        }
        if indexPath.row == 1 {
            print("Start With Why")
        startWithWhyPopupAction()
        }
        if indexPath.item == 2 {
            print("Find Your Flow")
        findYourFlowPopupAction()
        }
    }
    
}
