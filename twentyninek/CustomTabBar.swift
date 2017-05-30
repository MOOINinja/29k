//
//  CustomTabBar.swift
//  29K
//
//  Created by Chibi Anward on 17/04/17.
//  Copyright © 2017 Chibi Anward. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookLogin


class CustomTabBar: UITabBarController, UITabBarControllerDelegate {
    
    let layout = UICollectionViewFlowLayout()
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        _ = viewControllers?.index(of: viewController)
        /*
        if index == 2 {
            //let layout = UICollectionViewFlowLayout()
            return false
        }*/
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        checkIfUserIsLoggedIn()
        setupViewControllers()

        
    }
    
    func checkIfUserIsLoggedIn() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "UserToken")
        defaults.removeObject(forKey: "UserId")
        
        if (  defaults.object(forKey: "UserToken") == nil) {
            //Show if not logged in
            DispatchQueue.main.async {
                let loginController = StartViewController()
                self.present(loginController, animated: false, completion: nil)
            }
            return
        }
//        else {
//            let dataHandler = DataHandler()
//            dataHandler.getUser(userToken: defaults.object(forKey: "UserToken") as! String) { success in }
//        }
    }

    func setupViewControllers() {
        
        //Start
        let startNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_tab_icon_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "home_tab_icon_selected").withRenderingMode(.alwaysOriginal), title: "Login", rootViewController: StartViewController())
/*
        //Profile
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_tab_icon_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "profile_tab_icon_selected").withRenderingMode(.alwaysOriginal), title: "Home", rootViewController: ProfileViewController(collectionViewLayout: layout))
        
        //Team
        let teamNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "team__tab_icon_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "team_tab_icon_selected").withRenderingMode(.alwaysOriginal), title: "Teams", rootViewController: TeamViewController())
        
        //Courses
        let coursesNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "course_tab_icon_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "course_tab_icon_selected").withRenderingMode(.alwaysOriginal), title: "Courses", rootViewController: CourseOutlineViewController(collectionViewLayout: layout))
        
        //Feed
        let feedNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "feed_tab_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "feed_tab_selected").withRenderingMode(.alwaysOriginal), title: "Feed", rootViewController: FeedViewController())
        
*/
        let viewNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "feed_tab_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "feed_tab_selected").withRenderingMode(.alwaysOriginal), title: "Dummy", rootViewController: ViewController())
        
        tabBar.tintColor = UIColor.rgb(red: 109, green: 93, blue: 190, alpha: 1)
        
        viewControllers = [viewNavController]
        
        //tab item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        

    }
    
//    public func setbadge() {
//        // Access the elements (NSArray of UITabBarItem) (tabs) of the tab Bar
//        let tabItems = self.tabBar.items as NSArray!
//        
//        // In this case we want to modify the badge number of the third tab:
//        let tabItem = tabItems?[2] as! UITabBarItem
//        
//        // Now set the badge of the third tab
//        tabItem.badgeValue = "1"
//    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, title: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController{
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.title = title
        return navController
        
    }
    
}
