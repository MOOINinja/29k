//
//  DataHandler.swift
//  29K
//
//  Created by Patrik Adolfsson on 2017-04-22.
//  Copyright © 2017 Chibi Anward. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FacebookLogin


struct Variables {
    static var HWPRPoints: [HWPR] = [HWPR!](repeating: HWPR.init(Point: 0, Text: ""), count: 4)
    static var CurrentUser: User? = nil
    static var UserToken: String = "MTQ5Mzk3NTY0NXxDZ3dBQnpJeE9EQXdNRFE9fOKrXAoIbsVAMwZi5eClW67rIqRiHXnKvrh0_N4MCNZI" // Default value
    static var UserId: Int64 = 0 //1030003
    static var FacebookId: String = "" //"10155218634934224"
    static var FacebookToken = ""
    static var UserCards: [UserCard]? = []
    static var currentCardIndex = 0
    static var currentPageIndex = 0
    static var PublicUsers: [PublicUser] = []
    static var userIsTeamster = false
    static var UserHasInvite = false
    static var TeamInviteId: Int64 = 0
    static var TeamId: Int64 = 0
    static var Teams: [Team] = []
    static var LifePhilosophyStore: LifePhilosophy? = nil
    static var LocalTeamMembers = [Int64]()
    static var LocalTeamInvites = [Int64]()
    static var ShowOnbordingAtStart = false
    static var ShouldReloadProfile = false
    static var FindYourFlowAStore: FindYourFlow? = nil
    static var FindYourFlowStates: [Logged] = []
    static var FindYourFlowOrdered: [[Logged]] = []
    static var Courses: [Course] = [Course!](repeating: Course.init(Name: "", TotalSteps: 1, CompletedSteps: 0, Locked: true), count: 3)
    static var CoursesCompleted = 0
    static var CoursesCount = 3
    static var CourseId: Int = 0
    static var UserHasLifeScan = false
    static var UserHasStartWithWhy = false
    static var userHasFindYourFLow = false
    
}

enum Gender: Int {
    case Unknown = 0, Male = 1, Female = 2
}
enum MyCourses: Int {
    case done
    case start
    case teamSessionDefault
    case locked
    case teamSessionScheduled
    case ongoing
}

struct FindYourFlow {
    var id: Int64
    var Value: [Logged]
    var Nudge: String?
    var Themes: String?
}
struct Logged {
    var Text: String
    var Value1: Float
    var Value2: Float
    var Value3: Float
}

struct LifePhilosophy {
    var id: Int64
    var Aligned: Float
    var Life: LifeWork?
    var Work: LifeWork?
}

struct LifeWork {
    var Images: [String]
    var Labels: [String]
    var Text: String
}

struct Course {
    var Name: String
    var TotalSteps: Int
    var CompletedSteps: Int
    var Locked: Bool
}

struct CourseState {
    var id: Int64
    var Course: Course
    var TotalSteps: Int
    var CompletedSteps: Int
    var Locked: Bool
}

struct UserCard {
    let index: Int
    let User: User
    let Result: [HWPR]
}

struct HWPR {
    var Point: Int
    var Text: String
}

struct Team {
    let id: Int64
    let Members: [Int64]
    var Invites: [Int64]
}

struct State {
    let id: Int64
    let Hide: Bool
    let userId: Int64
    let Health: HWPR
    let Work: HWPR
    let Play: HWPR
    let Relationships: HWPR
    let Share: Bool
    let Anonymous: Bool
    let submitted: Date;
    let at: Date
}

struct TeamUser {
    let UserId: Int64
    let Image: UIImageView
}

struct User {
    let UserId: Int64
    let FirstName: String
    let LastName: String
    let Age: String
    var Email: String
    let Image: UIImageView
    var Occupation: String
    var Location: String
    var School: String
}
struct PublicUser {
    let UserId: Int64
    let FirstName: String
    let LastName: String
    let Teamster: Bool
    let FacebookId: String
    let Image: UIImageView
    let Occupation: String
    let Location: String
    let School: String
}

struct Module {
    let Title: String?
    let Step:  String?
    let Description: String?
    let PointsTitle: String?
    let InputTitle: String?
    var InputText: String?
    let ModuleIcon: String?
}

class DataHandler {
    
    let environmentUrl = "https://api-dot-twentyninekilo-play.appspot.com" // DEV
    //let environmentUrl = "https://api-dot-twentyninekilo-test.appspot.com" // TEST
    
    //let environmentUrl = Bundle.main.infoDictionary!["MY_API_BASE_URL_ENDPOINT"] as! String
    
    //  ****************************************************************************************
    //  Mark: Helper functions
    //  ****************************************************************************************
    public func showOverlay(name: String) -> Bool {
        let defaults = UserDefaults.standard
        //defaults.removeObject(forKey: name) // Uncomment to force popup
        if( defaults.value(forKey: name) == nil ) {
            storeLocalData(object: name, value: "shown")
            return true
        }
        return false
    }
    
    public func storeLocalData(object: String, value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: object)
        defaults.synchronize()
    }
    
    public func clearLocalDate() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    public func orderFindYourFlowStates(completionHandler:@escaping (Bool) -> ()) {
        let states = Variables.FindYourFlowStates
        //Variables.FindYourFlowStates = [Logged]()
        Variables.FindYourFlowOrdered = []
        
        // Value1 ordered high to low.
        let values1 = states.sorted(by: { $0.Value1 > $1.Value1 })
        Variables.FindYourFlowOrdered.append(values1)
        
        if ( Variables.FindYourFlowOrdered[0].count >= 6 ) {
            // Get top 3 and bottom 3
            let sliceTop3 = Variables.FindYourFlowOrdered[0][0...2]
            let sliceBottom3 = Variables.FindYourFlowOrdered[0][Variables.FindYourFlowOrdered[0].count-3...Variables.FindYourFlowOrdered[0].count-1]
     
            let arrayTop3: [Logged] = Array(sliceTop3)
            let arrayBottom3: [Logged] = Array(sliceBottom3)
            
            Variables.FindYourFlowOrdered[0] = arrayTop3 + arrayBottom3
        }
        
        // Value2 ordered high to low.
        let values2 = states.sorted(by: { $0.Value2 > $1.Value2 })
        Variables.FindYourFlowOrdered.append(values2)
        if ( Variables.FindYourFlowOrdered[1].count >= 6 ) {
            // Get top 3 and bottom 3
            let sliceTop3 = Variables.FindYourFlowOrdered[1][0...2]
            let sliceBottom3 = Variables.FindYourFlowOrdered[1][Variables.FindYourFlowOrdered[1].count-3...Variables.FindYourFlowOrdered[1].count-1]
            
            let arrayTop3: [Logged] = Array(sliceTop3)
            let arrayBottom3: [Logged] = Array(sliceBottom3)
            
            Variables.FindYourFlowOrdered[1] = arrayTop3 + arrayBottom3
        }

        
        // Value3 ordered high to low.
        let values3 = states.sorted(by: { $0.Value3 > $1.Value3 })
        Variables.FindYourFlowOrdered.append(values3)
        if ( Variables.FindYourFlowOrdered[2].count >= 6 ) {
            // Get top 3 and bottom 3
            let sliceTop3 = Variables.FindYourFlowOrdered[2][0...2]
            let sliceBottom3 = Variables.FindYourFlowOrdered[2][Variables.FindYourFlowOrdered[2].count-3...Variables.FindYourFlowOrdered[2].count-1]
            
            let arrayTop3: [Logged] = Array(sliceTop3)
            let arrayBottom3: [Logged] = Array(sliceBottom3)
            
            Variables.FindYourFlowOrdered[2] = arrayTop3 + arrayBottom3
        }
        
        completionHandler(true)
        
    }
    
    
    //  ****************************************************************************************
    //  Mark: API functions
    //  ****************************************************************************************
    
    public func storeLogged(logged: Logged, completionHandler:@escaping (Bool) -> ()) {
        
        
        Variables.FindYourFlowStates.append(logged)
  
        var v1 = logged.Value1
        if ( logged.Value1 == 0 ) {
            v1 = 0.1
        }
        
        var v2 = logged.Value2
        if ( logged.Value2 == 0 ) {
            v2 = 0.1
        }
        
        var v3 = logged.Value3
        if ( logged.Value3 == 0 ) {
            v3 = 0.1
        }
        
        let loggedDict = ["valueA":v1,
                            "ValueB":v2,
                            "ValueC":v3,
                            "text": logged.Text
                            ] as [String : Any]
        
        let dictionary = ["userId": Variables.CurrentUser?.UserId ?? 0,
                          "courseId": Variables.CourseId,
                          "values": [loggedDict],
                          "nudges": "",
                          "themes": ""
            ] as [String : Any]

        
        
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            let url = URL(string: "\(environmentUrl)/courses/\( Variables.CourseId )/find_your_flow/states")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = theJSONData
            
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")

            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            
                            
                            self.orderFindYourFlowStates() { success in
                                completionHandler(true)
                            }
                        }
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
    }
    
    
    public func storeCourseState(completionHandler:@escaping (Bool) -> ()) {
        
        if( Variables.CourseId == 0 ) { completionHandler(false) }
        
        let lifeScanDict = ["total":Variables.Courses[0].TotalSteps,
                            "completed":Variables.Courses[0].CompletedSteps,
                            "locked":Variables.Courses[0].Locked] as [String : Any]
        
        let startWithWhyDict = ["total":Variables.Courses[1].TotalSteps,
                                "completed":Variables.Courses[1].CompletedSteps,
                                "locked":Variables.Courses[1].Locked] as [String : Any]
        
        let findYourFlowDict = ["total":Variables.Courses[2].TotalSteps,
                                "completed":Variables.Courses[2].CompletedSteps,
                                "locked":Variables.Courses[2].Locked] as [String : Any]
        
        let dictionary = ["userId": Variables.CurrentUser?.UserId ?? 0,
                          "courseId": Variables.CourseId,
                          "lifeScan": lifeScanDict,
                          "lifePhilosophy": startWithWhyDict,
                          "findYourFlow": findYourFlowDict
            ] as [String : Any]
        
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {

        
        let url = URL(string: "\(environmentUrl)/courses/\( Variables.CourseId )/states")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = theJSONData
        
        request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("\(String(describing: error))")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                do {
                    let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    if( JsonDict.count != 0 ) {
                        completionHandler(true)
                    }
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            })
        }
        task.resume()
        }
    }
    
    public func getCourses(completionHandler:@escaping (Bool) -> ()) {
        if let url = NSURL(string:"\(environmentUrl)/courses") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                        if( JsonDict.count > 0 ) {
                            let course = JsonDict.firstObject as! NSDictionary
                            
                            Variables.CourseId = course.value(forKey: "id") as! Int
                        }
                        
                        completionHandler(true)
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                    
                })
            }
            task.resume()
        }
    }
    
    public func storeLifePhilosophy(completionHandler:@escaping (Bool) -> ()) {
        
        let lifeDict = ["text":Variables.LifePhilosophyStore?.Life?.Text ?? "",
                        "images":Variables.LifePhilosophyStore?.Life?.Images ?? [],
                        "labels":Variables.LifePhilosophyStore?.Life?.Labels ?? []] as [String : Any]
        
        let workDict = ["text":Variables.LifePhilosophyStore?.Work?.Text ?? "",
                        "images":Variables.LifePhilosophyStore?.Work?.Images ?? [],
                        "labels":Variables.LifePhilosophyStore?.Work?.Labels ?? []] as [String : Any]
        
        let dictionary = ["userId": Variables.CurrentUser?.UserId ?? 0,
                          "aligned": Variables.LifePhilosophyStore?.Aligned ?? 50.0,
                          "life": lifeDict,
                          "work": workDict,
                          "share": false,
                          "anonymous": false
            ] as [String : Any]
        
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            // create post request
            let url = URL(string: "\(environmentUrl)/modules/life_philosophy/states")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.httpBody = theJSONData
            
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            completionHandler(true)
                        }
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
    }
    
    public func leaveUserTeam(teamId: Int64, userId: Int64, completionHandler:@escaping (Bool) -> ()) {
        
        if let url = NSURL(string:"\(environmentUrl)/teams/\(teamId)/users/\(userId)") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "DELETE"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            completionHandler(true)
                        }
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
    }
    
    public func createTeam(userId: Int64, completionHandler:@escaping (Int64) -> ()) {
        
        let json: [String: [Any]] = ["members": [userId]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        if let url = NSURL(string:"\(environmentUrl)/teams") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            completionHandler(JsonDict.value(forKey: "id") as! Int64)
                        }
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
        
        
        
    }
    
    public func inviteUser(teamId: Int64, from: Int64, to: Int64, completionHandler:@escaping (Bool) -> ()) {
        
        let json: [String: Any] = ["teamId": teamId,"from":from,"to":to]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        if let url = NSURL(string:"\(environmentUrl)/teams/\(teamId)/invites") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            completionHandler(true)
                            //Variables.Teams[0].Invites.append(to)
                        }
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
    }
    
    public func acceptInvite(teamId: Int64, inviteId: Int64, completionHandler:@escaping (Bool) -> ()) {
        
        if let url = NSURL(string:"\(environmentUrl)/teams/\(teamId)/invites/\(inviteId)/accept") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "PUT"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            self.getUser(userToken: Variables.UserToken) { user in
                                
                                completionHandler(true)
                                
                            }
                            
                        }
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
        
    }
    
    public func rejectInvite(teamId: Int64, inviteId: Int64, completionHandler:@escaping (Bool) -> ()) {
        
        if let url = NSURL(string:"\(environmentUrl)/teams/\(teamId)/invites/\(inviteId)/reject") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "PUT"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        if( JsonDict.count != 0 ) {
                            completionHandler(true)
                        }
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
        
    }
    
    public func getUserObject(userToken: String, completionHandler:@escaping (NSDictionary) -> ()) {
        if let url = NSURL(string:"\(environmentUrl)/users/me/poll") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(userToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let poll = JsonDict["poll"] as! NSDictionary
                        let user = poll["user"] as! NSDictionary
                        
                        completionHandler(user)
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
        
    }
    
    public func updateUserFacebook(userToken: String, userId: Int64, firstName: String?, lastName: String?, birthday: String?) {
        getUserObject(userToken: userToken) { user in
            let userDict : NSMutableDictionary = NSMutableDictionary(dictionary: user)
            
            guard let fName = firstName else { return }
            userDict["firstName"] = fName
            
            guard let lName = lastName else { return }
            userDict["lastName"] = lName
            
            guard let bDay = birthday else { return }
            userDict["birthday"] = bDay
            
            
            // Update user in DB
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: userDict,
                options: []) {
                
                
                // create post request
                let url = URL(string: "\(self.environmentUrl)/users/\(userId)")!
                var request = URLRequest(url: url)
                
                request.httpMethod = "PUT"
                request.httpBody = theJSONData
                
                request.addValue("29k \(userToken)", forHTTPHeaderField: "Authorization")
                request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let _ = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    
                    // Done
                    // self.getUser(userToken: Variables.UserToken)
                    
                }
                task.resume()
                
            }
        }
    }
    
    public func getTeamInvites(teamId: Int64) {
        if let url = NSURL(string:"\(environmentUrl)/teams/\(teamId)/invites") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                do {
                    let JsonArr = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                    
                    
                    Variables.Teams[0].Invites.removeAll()
                    for user in JsonArr.enumerated() {
                        let usr = user.element as! NSDictionary
                        
                        if( usr["accepted"] == nil && usr["rejected"] == nil) {
                            Variables.Teams[0].Invites.append(usr.value(forKey: "to") as! Int64)
                        }
                        
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    public func updateUser(userToken: String, userId: Int64, occupation: String?, school: String?, location: String?, alternativeEmail: String?, completionHandler:@escaping (Bool) -> ()) {
        
        getUserObject(userToken: userToken) { user in
            let userDict : NSMutableDictionary = NSMutableDictionary(dictionary: user)
            
            guard let _occupation = occupation else { return }
            userDict["occupation"] = _occupation
            
            guard let _school = school else { return }
            userDict["school"] = _school
            
            guard let _location = location else { return }
            userDict["location"] = _location
            
            guard let _alternativeEmail = alternativeEmail else { return }
            //let emailArray = (userDict["email"] as! NSArray).mutableCopy()
            //(emailArray as AnyObject).add(_alternativeEmail)
            userDict["email"] = [_alternativeEmail]
            
            // TODO: Send to DB
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: userDict,
                options: []) {
                
                
                // create post request
                let url = URL(string: "\(self.environmentUrl)/users/\(userId)")!
                var request = URLRequest(url: url)
                
                request.httpMethod = "PUT"
                request.httpBody = theJSONData
                
                request.addValue("29k \(userToken)", forHTTPHeaderField: "Authorization")
                request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let _ = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        completionHandler(true)
                    })
                }
                task.resume()
            }
        }
    }
    
    public func getUserDetails(userId: Int64, completionHandler:@escaping (PublicUser) -> ()) {
        
        if let url = NSURL(string:"\(environmentUrl)/users/\(userId)") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    do {
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        var facebookId = ""
                        let profileImage = UIImageView()
                        profileImage.image = UIImage(named: "defaultProfile")
                        
                        if (JsonDict.value(forKey: "facebookId") != nil){
                            facebookId = JsonDict.value(forKey: "facebookId") as! String
                            let url = URL(string: "https://graph.facebook.com/\( facebookId )/picture?type=small")
                            let data = try? Data(contentsOf: url!)
                            profileImage.image = UIImage(data: data!)
                        }
                        
                        let user = PublicUser(UserId: JsonDict["id"] as! Int64, FirstName: JsonDict["firstName"] as! String, LastName: JsonDict["lastName"] as! String, Teamster: JsonDict["teamster"] as! Bool, FacebookId: facebookId, Image: profileImage, Occupation: "Student", Location: "Stockholm", School: "KTH")
                        
                        completionHandler(user)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
    }
    
    public func getAllUsers() {
        
        if let url = NSURL(string:"\(environmentUrl)/users") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        
                        let JsonArray = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                        Variables.PublicUsers.removeAll()
                        for user in JsonArray.enumerated() {
                            let userObject = user.element as! NSDictionary
                            var facebookId = ""
                            let profileImage = UIImageView()
                            profileImage.image = UIImage(named: "defaultProfile")
                            
                            if (userObject.value(forKey: "facebookId") != nil){
                                facebookId = userObject.value(forKey: "facebookId") as! String
                                let url = URL(string: "https://graph.facebook.com/\( facebookId )/picture?type=small")
                                let data = try? Data(contentsOf: url!)
                                if( data != nil ) {
                                    profileImage.image = UIImage(data: data!)
                                }
                            }
                            
                            Variables.PublicUsers.append(PublicUser(UserId: userObject.value(forKey: "id") as! Int64,
                                                                    FirstName: userObject.value(forKey: "firstName") as! String,
                                                                    LastName: userObject.value(forKey: "lastName") as! String,
                                                                    Teamster: userObject.value(forKey: "teamster") as! Bool,
                                                                    FacebookId: facebookId,
                                                                    Image: profileImage,
                                                                    Occupation: "Student",
                                                                    Location: "Stockholm",
                                                                    School: "KTH"))
                            
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
    }
    
    public func getUser(userToken: String, completionHandler:@escaping (Bool) -> ()) {

        
        if let url = NSURL(string:"\(environmentUrl)/users/me/poll") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                //DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        let poll = JsonDict["poll"] as! NSDictionary
                        let user = poll["user"] as! NSDictionary
                        var hwpr: [[String:Any]] = []
                        var courseStats = [HWPR!](repeating: HWPR.init(Point: 0, Text: ""), count: 4)
                        
                        if( poll["hwprStates"] != nil ) {
                            Variables.UserHasLifeScan = true
                            
                            hwpr = (poll["hwprStates"] as! NSArray) as! [[String:Any]]
                            
                            
                            
                            let arr = hwpr.sorted {
                                (dictOne, dictTwo) -> Bool in
                                let d1 =  Dates.parseRFC3339Date(dictOne["submitted"] as? String)
                                let d2 = Dates.parseRFC3339Date(dictTwo["submitted"] as? String)
                                
                                return d1! < d2!
                            }
                            
                            let p = arr.last! as NSDictionary
                            
                            for items in p {
                                let item = items.value
                                
                                if (items.key as! String == "health") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[0] = hwpr
                                }
                                if (items.key as! String == "work") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[1] = hwpr
                                    
                                }
                                if (items.key as! String == "play") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[2] = hwpr
                                }
                                if (items.key as! String == "relationships") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[3] = hwpr
                                }
                                
                            }
                            Variables.HWPRPoints = (courseStats as! [HWPR])
                        }
                        
                        if( user["teamster"] as! Bool == true ) {
                            let teams = poll["teams"] as! NSArray
                            let team = teams.lastObject as! NSDictionary
                            
                            if( team["members"]  !=  nil) {
                                let members = team["members"] as! NSArray
                                
                                Variables.userIsTeamster = true
                                Variables.TeamId = team["id"] as! Int64
                                
                                Variables.Teams.append(Team(id: team["id"] as! Int64, Members: members as! [Int64], Invites: [Int64]()))
                            }
                        }
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "YYYY-M-d"
                        let date = Dates.parseRFC3339Date(user["birthday"] as? String)
                        let calendar = Calendar.current
                        
                        let year = calendar.component(.year, from: date!)
                        let month = calendar.component(.month, from: date!)
                        let day = calendar.component(.day, from: date!)
                        
                        
                        let myDOB = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
                        let myAge = String(myDOB.age)
                        
                        let profileImage = UIImageView()
                        
                        if (user["facebookId"] != nil) {
                            Variables.FacebookId = user["facebookId"] as! String
                            let url = URL(string: "https://graph.facebook.com/\( Variables.FacebookId )/picture?type=large")
                            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            profileImage.image = UIImage(data: data!)
                        }
                        
                        var occupation = ""
                        if ( user["occupation"] != nil ) {
                            occupation = user["occupation"] as! String
                        }
                        var location = ""
                        if ( user["location"] != nil ) {
                            location = user["location"] as! String
                        }
                        var school = ""
                        if ( user["school"] != nil ) {
                            school = user["school"] as! String
                        }
                        
                        var email = ""
                        if ( user["email"] != nil ) {
                            email = (user["email"] as! NSArray).firstObject as! String
                        }
                        
                        let userObject = User(UserId: user["id"] as! Int64 , FirstName: user["firstName"] as! String , LastName: user["lastName"] as! String , Age: myAge, Email: email , Image: profileImage, Occupation: occupation, Location: location, School: school)
                        
                        Variables.CurrentUser = userObject
                        
                        if ( poll["teamInvites"] != nil ) {
                            let teamInvites = poll["teamInvites"] as! NSArray
                            for invites in teamInvites.enumerated() {
                                let invite = invites.element as! NSDictionary
                                if ( invite.value(forKey: "to") as? Int64 == Variables.CurrentUser?.UserId && invite.value(forKey: "accepted") == nil && invite.value(forKey: "rejected") == nil) {
                                    Variables.UserHasInvite = true
                                    Variables.TeamId = invite.value(forKey: "teamId") as! Int64
                                    Variables.TeamInviteId = invite.value(forKey: "id") as! Int64
                                    
                                    break
                                }
                            }
                        }
             
                        if ( poll["lifePhilosophyStates"] != nil ) {
                            
                            Variables.UserHasStartWithWhy = true
                            
                            let lifePhilosophyStates = (poll["lifePhilosophyStates"] as! NSArray) as! [[String:Any]]
                            
                            let arr = lifePhilosophyStates.sorted {
                                (dictOne, dictTwo) -> Bool in
                                let d1 =  Dates.parseRFC3339Date(dictOne["submitted"] as? String)
                                let d2 = Dates.parseRFC3339Date(dictTwo["submitted"] as? String)
                                
                                return d1! < d2!
                            }
                            
                            let lifePhilosophyState = arr.last! as NSDictionary
                            
                            let lifeObject = lifePhilosophyState.value(forKey: "life") as! NSDictionary
                            let life = LifeWork.init(Images: (lifeObject.value(forKey: "images") as! NSArray) as! [String], Labels: (lifeObject.value(forKey: "labels") as! NSArray) as! [String], Text: lifeObject.value(forKey: "text") as? String ?? "")
                            
                            let workObject = lifePhilosophyState.value(forKey: "work") as! NSDictionary
                            let work = LifeWork.init(Images: (workObject.value(forKey: "images") as! NSArray) as! [String], Labels: (workObject.value(forKey: "labels") as! NSArray) as! [String], Text: workObject.value(forKey: "text") as? String ?? "")
                            
                            Variables.LifePhilosophyStore = LifePhilosophy.init(
                                id: lifePhilosophyState.value(forKey: "id") as! Int64,
                                Aligned: lifePhilosophyState.value(forKey: "aligned") as! Float,
                                Life: life,
                                Work: work)
                        }
                        
                        // TODO: Get all findYourFlowStates
                        if( poll["findYourFlowStates"] != nil ) {
                            Variables.userHasFindYourFLow = true
                            let findYourFLowStates = (poll["findYourFlowStates"] as! NSArray) as! [[String:Any]]
                            
                            for state in findYourFLowStates.enumerated() {
                               
                                let stateDict = state.element as NSDictionary
                                let val = (stateDict.value(forKey: "values") as! NSArray).firstObject as! NSDictionary
                                let value1 = val.value(forKey: "valueA") as? Float ?? 0.0
                                let value2 = val.value(forKey: "valueB") as? Float ?? 0.0
                                let value3 = val.value(forKey: "valueC") as? Float ?? 0.0
                                let text = val.value(forKey: "text") as? String ?? ""
                                let logged = Logged(Text: text, Value1: value1, Value2: value2, Value3: value3)
                                
                                Variables.FindYourFlowStates.append(logged)
                                
                            }
                            
                            
                        }
                        
                        
                        if (poll["courseStates"] != nil ) {
                            
                            let courseStatesStates = (poll["courseStates"] as! NSArray) as! [[String:Any]]
                            
                            let arr = courseStatesStates.sorted {
                                (dictOne, dictTwo) -> Bool in
                                let d1 =  Dates.parseRFC3339Date(dictOne["submitted"] as? String)
                                let d2 = Dates.parseRFC3339Date(dictTwo["submitted"] as? String)
                                
                                return d1! < d2!
                            }
                            
                             let courseState = arr.last! as NSDictionary
                            
                            let lifeScan = courseState.value(forKey: "lifeScan") as! NSDictionary
                            let lifeScanObject = Course(Name: "LIFE SCAN",
                                                        TotalSteps: lifeScan.value(forKey: "total") as! Int,
                                                        CompletedSteps: lifeScan.value(forKey: "completed") as! Int,
                                                        Locked: lifeScan.value(forKey: "locked") as! Bool)
                            
                            Variables.Courses[0] = lifeScanObject
                            if ( lifeScanObject.Locked == false ) {
                                Variables.CoursesCompleted = 1
                            }
                            
                            
                            let lifePhilosophy = courseState.value(forKey: "lifePhilosophy") as! NSDictionary
                            let lifePhilosophyObject = Course(Name: "START WITH WHY",
                                                        TotalSteps: lifePhilosophy.value(forKey: "total") as! Int,
                                                        CompletedSteps: lifePhilosophy.value(forKey: "completed") as! Int,
                                                        Locked: lifePhilosophy.value(forKey: "locked") as! Bool)
                            
                            Variables.Courses[1] = lifePhilosophyObject
                            if ( lifePhilosophyObject.Locked == false ) {
                                Variables.CoursesCompleted = 2
                            }
                            
                            let findYourFlow = courseState.value(forKey: "findYourFlow") as! NSDictionary
                            let findYourFlowObject = Course(Name: "FIND YOUR FLOW",
                                                            TotalSteps: findYourFlow.value(forKey: "total") as! Int,
                                                            CompletedSteps: findYourFlow.value(forKey: "completed") as! Int,
                                                            Locked: findYourFlow.value(forKey: "locked") as! Bool)
                            
                            Variables.Courses[2] = findYourFlowObject
                            if ( findYourFlowObject.Locked == false ) {
                                Variables.CoursesCompleted = 3
                            }
                            
                            
                            
                        
                        }
                        completionHandler(true)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                //})
            }
            task.resume()
        }
    }
    
    
    public func storeHWPR(hwpr: [HWPR], completionHandler:@escaping (Bool) -> ()) {
        
        let healthDict = ["points":hwpr[0].Point,"text":hwpr[0].Text] as [String : Any]
        let workDict = ["points":hwpr[1].Point,"text":hwpr[1].Text] as [String : Any]
        let playDict = ["points":hwpr[2].Point,"text":hwpr[2].Text] as [String : Any]
        let relationshipsDict = ["points":hwpr[3].Point,"text":hwpr[3].Text] as [String : Any]
        
        let dictionary = ["id": 0,
                          "userId": Variables.UserId,
                          "health": healthDict,
                          "work": workDict,
                          "play": playDict,
                          "relationships": relationshipsDict,
                          "share": false,
                          "anonymous": false,
                          "submitted": "2017-04-24T13:12:16Z",
                          "at":"2017-04-24T14:14:16Z"
            
            ] as [String : Any]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            let url = URL(string: "\(environmentUrl)/hwpr/states")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.httpBody = theJSONData
            
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.getHWPR() {success in
                        completionHandler(true)
                    }
                    
                })
            }
            task.resume()
        }
    }
    
    public func getCards(completionHandler:@escaping (Bool) -> ()) {
        
        if let url = NSURL(string:"\(environmentUrl)/hwpr/states/users/?n=5") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let _states = JsonDict["states"] as! NSArray
                        
                        for i in 0..._states.count-1 {
                            let states = _states[i] as! NSDictionary
                            let user = states["user"] as! NSDictionary
                            let hwpr = states["hwpr"] as! NSDictionary
                            
                            
                            // User
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "YYYY-M-d"
                            let date = Dates.parseRFC3339Date(user["birthday"] as? String)
                            let calendar = Calendar.current
                            let year = calendar.component(.year, from: date!)
                            let month = calendar.component(.month, from: date!)
                            let day = calendar.component(.day, from: date!)
                            
                            
                            let myDOB = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
                            let myAge = String(myDOB.age)
                            
                            let profileImage = UIImageView()
                            
                            if (user["facebookId"] != nil) {
                                Variables.FacebookId = user["facebookId"] as! String
                                let url = URL(string: "https://graph.facebook.com/\( Variables.FacebookId )/picture?type=large")
                                let data = try? Data(contentsOf: url!)
                                if( data != nil ) {
                                    profileImage.image = UIImage(data: data!)
                                }
                            }
                            
                            var occupation = ""
                            if ( user["occupation"] != nil ) {
                                occupation = user["occupation"] as! String
                            }
                            var location = ""
                            if ( user["location"] != nil ) {
                                location = user["location"] as! String
                            }
                            var school = ""
                            if ( user["school"] != nil ) {
                                school = user["school"] as! String
                            }
                            //                            var email = ""
                            //                            if ( user["email"] != nil ) {
                            //                                email = (user["email"] as! NSArray).firstObject as! String
                            //                            }
                            
                            let userObject = User(UserId: user["id"] as! Int64 , FirstName: user["firstName"] as! String , LastName: user["lastName"] as! String , Age: myAge, Email: "" , Image: profileImage, Occupation: occupation, Location: location, School: school)
                            
                            // HWPR
                            var courseStats = [HWPR?](repeating: nil, count: 4)
                            
                            let p = hwpr
                            
                            for items in p {
                                let item = items.value
                                
                                if (items.key as! String == "health") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[0] = hwpr
                                }
                                if (items.key as! String == "work") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[1] = hwpr
                                    
                                }
                                if (items.key as! String == "play") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[2] = hwpr
                                }
                                if (items.key as! String == "relationships") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[3] = hwpr
                                }
                                
                            }
                            
                            let userCard = UserCard.init(index: i, User: userObject, Result: courseStats as! [HWPR])
                            
                            Variables.UserCards?.append(userCard)
                            
                            completionHandler(true)
                            
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                })
            }
            
            task.resume()
        }
    }
    
    public func loginWithFaceBookToken(facebookToken: String, completionHandler:@escaping (Bool) -> ()) {
        
        let dictionary = [ "token": facebookToken] as [String : Any]
        
        do {
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: dictionary,
                options: []) {
                
                // create post request
                let url = URL(string: "\(environmentUrl)/users/signin/facebook")!
                var request = URLRequest(url: url)
                request.addValue("29k \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
                request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
                request.httpMethod = "POST"
                request.httpBody = theJSONData
                
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    do {
                        
                        let JsonDict = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                        
                        Variables.UserId = JsonDict.value(forKey: "userId") as! Int64
                        Variables.UserToken = JsonDict.value(forKey: "token") as! String
                        
                        let defaults = UserDefaults.standard
                        defaults.set(Variables.UserToken, forKey: "UserToken")
                        defaults.set(Variables.UserId, forKey: "UserId")
                        
                        completionHandler(true)
                        
                    }  catch let error as NSError {
                        print(error)
                    }
                }
                task.resume()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    public func getHWPR(completionHandler:@escaping (Bool) -> ()) {
        
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "UserToken") != nil) {
            Variables.UserToken = defaults.object(forKey: "UserToken") as! String
        }
        
        if let url = NSURL(string:"\(environmentUrl)/users/me/poll") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("29k \( Variables.UserToken )", forHTTPHeaderField: "Authorization")
            request.addValue("application/vnd.29k.v10+json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    do {
                        
                        let JsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let poll = JsonDict["poll"] as! NSDictionary
                        var hwpr: [[String:Any]] = []
                        
                        
                        var courseStats = [HWPR!](repeating: HWPR.init(Point: 0, Text: ""), count: 4)
                        
                        if( poll["hwprStates"] != nil ) {
                            hwpr = (poll["hwprStates"] as! NSArray) as! [[String:Any]]
                            
                            let arr = hwpr.sorted {
                                (dictOne, dictTwo) -> Bool in
                                let d1 =  Dates.parseRFC3339Date(dictOne["submitted"] as? String)
                                let d2 = Dates.parseRFC3339Date(dictTwo["submitted"] as? String)
                                
                                return d1! < d2!
                            }
                            
                            let p = arr.last! as NSDictionary
                            
                            for items in p {
                                let item = items.value
                                
                                if (items.key as! String == "health") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[0] = hwpr
                                }
                                if (items.key as! String == "work") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[1] = hwpr
                                    
                                }
                                if (items.key as! String == "play") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[2] = hwpr
                                }
                                if (items.key as! String == "relationships") {
                                    let itm = item as! NSDictionary
                                    let i = itm["points"] as! Int
                                    let s = itm["text"] as! String
                                    let hwpr = HWPR(Point: i, Text: s)
                                    courseStats[3] = hwpr
                                }
                                
                            }
                            Variables.HWPRPoints = (courseStats as! [HWPR])
                            completionHandler(true)
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                })
            }
            task.resume()
        }
    }
}

