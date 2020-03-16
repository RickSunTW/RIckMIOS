//
//  SearchFriendAddViewController.swift
//  RickMplus
//
//  Created by RickSun on 2020/3/6.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class SearchFriendAddViewController: UIViewController {
    
    @IBOutlet weak var searchFriendTableView: UITableView!
    @IBOutlet weak var searchFriendBar: UISearchBar!
    
    
    var allUsers = UserInfo.share.allUsers
    var searchUser: [Users] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchFriendTableView.delegate = self
        
        searchFriendTableView.dataSource = self
        
        searchFriendBar.delegate = self as? UISearchBarDelegate
        
        for userIndex in 0...UserInfo.share.allUsers.count-1 {
            let str = String()
            if str == UserInfo.share.allUsers[userIndex].email {
                searchUser.append(UserInfo.share.allUsers[userIndex])
            }
        }
    }
}


extension SearchFriendAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allUsers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriend", for: indexPath) as? SearchFriendTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        cell.searchFriendName.text = allUsers[indexPath.row].name
        cell.searchFriendName.layer.cornerRadius = 20
        
        return cell
    }
}


extension SearchFriendAddViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        searchFriendBar.resignFirstResponder()
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchFriendBar.text?.count != 0 {
            self.searchUser.removeAll()
            
        }
        return true
    }
    
}
