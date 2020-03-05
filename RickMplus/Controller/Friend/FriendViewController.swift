//
//  ViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/1/30.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import Firebase
import JGProgressHUD

class FriendViewController: UIViewController {
    @IBOutlet weak var friendTableView: UITableView!
    
    @IBAction func addFriendOrGroupBtn(_ sender: Any) {
        performSegue(withIdentifier: "AddFriendOrGroup", sender: nil)
    }
    var userProfileManager = UserProfileManager()
    var userData:Users?
    //    var userProfileData = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()
        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.separatorStyle = .none
        userProfileManager.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userProfileManager.getUserData(id: "\(UserInfo.share.logInUserUid)")
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.0)
        self.tabBarController?.tabBar.isHidden = false
        
    }
}

extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return 4 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0: return 1
        case 1: return 1
        case 2: return 2
        case 3: return UserInfo.share.friendList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendPersonal", for: indexPath) as? FriendPersonalTableViewCell else {
                
                return UITableViewCell()
                
            }
            
            cell.friendPersonalName.text = userData?.name
            
            cell.friendPersonalStatus.text = userData?.status
            
            if let personalPhoto = userData?.photoURL{
                guard let url = URL(string: personalPhoto) else {
                    return UITableViewCell()
                }

                cell.friendPersonalImage.kf.setImage(with: url)
                cell.friendPersonalImage.contentMode = .scaleToFill
                
            }
            
            return cell
            
        }
        else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCompany", for: indexPath) as? FriendCompanyTableViewCell else {
                
                return UITableViewCell()
            }
        
            let twmImage = UIImage(named: "TWM")
            
            cell.friendCompanyImage.image = twmImage
        
            cell.friendCompanyName.text = "台灣大哥大"
            
            cell.friendCompanyStatus.text = "台灣大哥大與你生活在一起～"
            
            return cell
            
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCompanyGroup", for: indexPath) as? FriendCompanyGroupTableViewCell else {
                    
                    return UITableViewCell()
                }
                
                let twmImage = UIImage(named: "TWM")
                           
                cell.friendCompanyGroupImage.image = twmImage
                       
                
                cell.friendCompanyGroupName.text = "PT Group"
                
                return cell
                
            } else if indexPath.row == 1 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendGroup", for: indexPath) as? FriendGroupTableViewCell else {
                    
                    return UITableViewCell()
                }
                
                cell.friendGroupName.text = "下午茶團購群"
                
                return cell
                
            }
            
        }
        else if indexPath.section == 3 {
            
            guard let friendListWorksCell = tableView.dequeueReusableCell(withIdentifier: "FriendCompany", for: indexPath) as? FriendCompanyTableViewCell else {
                
                return UITableViewCell()
            }
            
            guard let friendListFriendsCell = tableView.dequeueReusableCell(withIdentifier: "FriendPersonal", for: indexPath) as? FriendPersonalTableViewCell else {
                
                return UITableViewCell()
            }
            
            if UserInfo.share.friendList[indexPath.row].colleague {
                
                friendListWorksCell.friendCompanyName.text = UserInfo.share.friendList[indexPath.row].name
                
                friendListWorksCell.friendCompanyStatus.text = UserInfo.share.friendList[indexPath.row].status
                
                if let friendsPhoto = UserInfo.share.friendList[indexPath.row].photoURL {
                    
                    guard let url = URL(string: friendsPhoto) else {
                        return UITableViewCell()
                    }
                    friendListWorksCell.friendCompanyImage.kf.setImage(with: url)
                    
                    friendListWorksCell.friendCompanyImage.contentMode = .scaleToFill
                    
                    
                }
                
                return friendListWorksCell
                
            } else {
                
                friendListFriendsCell.friendPersonalName.text = UserInfo.share.friendList[indexPath.row].name
                
                friendListFriendsCell.friendPersonalStatus.text = UserInfo.share.friendList[indexPath.row].status
                
                if let friendsPhoto = UserInfo.share.friendList[indexPath.row].photoURL {
                    
                    guard let url = URL(string: friendsPhoto) else {
                        
                        return UITableViewCell()
                        
                    }
                    
                    friendListFriendsCell.friendPersonalImage.kf.setImage(with: url)
                    
                    friendListFriendsCell.friendPersonalImage.contentMode = .scaleToFill
                    
                }
                
                return friendListFriendsCell
                
            }
    
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
            
        case 0: return nil
            
        case 1: return "企業帳號(1)"
            
        case 2: return "群組(2)"
            
        case 3: return "好友(\(UserInfo.share.friendList.count))"
            
        default: return nil
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "ShowUserProfile", sender: nil)
            
        } else if indexPath.section == 3 {
            
            let selectUser = UserInfo.share.friendList[indexPath.row]
            
            showChatController(user: selectUser)
               
            
        } else {
            
        }

    }
    
    func showChatController(user: Users) {

             let chatLogControler = ChatLogController(collectionViewLayout: UICollectionViewLayout())
          
          navigationController?.pushViewController(chatLogControler, animated: true)
          
          chatLogControler.user = user
          

    }
    
}

extension FriendViewController: UserProfileManagerDelegate {
    
    func manager(_ manager: UserProfileManager, didgetUserData: Users) {
        
        self.userData = didgetUserData
        
        userProfileManager.getFriends(friendsemail: UserInfo.share.saveFriends)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.friendTableView.reloadData()
        }
    }
    
    func manager(_ manager: UserProfileManager, didFailWith error: Error) {
        
        print(error.localizedDescription)
        
    }
    
}
