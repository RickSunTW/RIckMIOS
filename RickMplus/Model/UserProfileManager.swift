//
//  UserProfileManager.swift
//  RickM+
//
//  Created by RickSun on 2020/2/14.
//  Copyright © 2020 RickSun. All rights reserved.
//

import Foundation
import Firebase
import Kingfisher
//import FirebaseFirestoreSwift

protocol UserProfileManagerDelegate: AnyObject {
    
    func manager(_ manager: UserProfileManager, didgetUserData: Users)
    
    func manager(_ manager: UserProfileManager, didFailWith error: Error)
    
}

class UserProfileManager {
    
    weak var delegate: UserProfileManagerDelegate?
    
    let db = Firestore.firestore()
    
    func getUserData(id: String) {
        
        db.collection("Users").whereField("id", isEqualTo: id).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let quary = querySnapshot else {
                    
                    return
                    
                }
                
                for document in quary.documents {
                    
                    do {
                        
                        let user = try document.data(as: Users.self, decoder: Firestore.Decoder())
                        
                        guard let loadingFriends = user?.friends else {
                            return
                        }
                        
                        UserInfo.share.saveFriends = []
                        UserInfo.share.colleagueFriendsPhoto = []
                        UserInfo.share.saveFriends = loadingFriends
                        
                        guard let userInfo = user else {return}
                        
                        self.delegate?.manager(self, didgetUserData: userInfo)
                        
                    } catch {
                        
                        print(error)
                        
                    }
                }
            }
        }
    }
    
    func getFriends(friendsemail: [String]) {
        
         UserInfo.share.friendList = []
        
        for email in friendsemail {
            
            db.collection("Users").whereField("email", isEqualTo: email).getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    guard let quary = querySnapshot else {
                        
                        return
                        
                    }
                    
                    for document in quary.documents {
                        
                        do {
                            
                            let friendInfo = try document.data(as: Users.self, decoder: Firestore.Decoder())
                            
                            guard let userInfo = friendInfo else {return}
                            
                            UserInfo.share.friendList.append(userInfo)
                            
                    
                        } catch {
                            
                            print(error)
                            
                        }
                    }
                }
            }
        }
    }
}
