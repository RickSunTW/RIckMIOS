//
//  ViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/19.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Kingfisher 

class SelectNewChatController: UIViewController {
    
    
    
    @IBOutlet weak var selectChatTableView: UITableView!
    
//    var chatMainViewController: ChatMainViewController?
    
//    傳值
    var chatHandler: ((Users) -> Void)?
    
//    brain
//    var chatMainViewController: ChatMainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectChatTableView.dataSource = self
        selectChatTableView.delegate = self
        selectChatTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}

extension SelectNewChatController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.share.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let addChatFriendCell = tableView.dequeueReusableCell(withIdentifier: "AddChatFriend", for: indexPath) as? SelectNewChatFriendTableViewCell else { return UITableViewCell()}
        
        guard let addChatWorkCell = tableView.dequeueReusableCell(withIdentifier: "AddChatCompany", for: indexPath) as? SelectNewChatWorkTableViewCell else { return UITableViewCell()}
        
        if UserInfo.share.friendList[indexPath.row].colleague {
            addChatWorkCell.selectChatWorkName.text = UserInfo.share.friendList[indexPath.row].name
            addChatWorkCell.selectChatWorkStatus.text = UserInfo.share.friendList[indexPath.row].status
            if let friendsPhoto = UserInfo.share.friendList[indexPath.row].photoURL {
                
                guard let url = URL(string: friendsPhoto) else {
                    return UITableViewCell()
                }
                addChatWorkCell.selectChatWorkImage.kf.setImage(with: url)
                
                addChatWorkCell.selectChatWorkImage.contentMode = .scaleToFill
                
                
            }
            
            return addChatWorkCell
            
        } else {
            
            addChatFriendCell.selectChatFriendNameLabel.text = UserInfo.share.friendList[indexPath.row].name
            addChatFriendCell.selectChatFriendStatusLabel.text = UserInfo.share.friendList[indexPath.row].status
            if let friendsPhoto = UserInfo.share.friendList[indexPath.row].photoURL {
                
                guard let url = URL(string: friendsPhoto) else {
                    return UITableViewCell()
                }
                addChatFriendCell.selectChatFriendImage.kf.setImage(with: url)
                
                addChatFriendCell.selectChatFriendImage.contentMode = .scaleToFill
                
                
            }
            
            return addChatFriendCell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        navigationController?.popViewController(animated: true)
        
        let chatFriend = UserInfo.share.friendList[indexPath.row]

        chatHandler?(chatFriend)

    }
    
}

