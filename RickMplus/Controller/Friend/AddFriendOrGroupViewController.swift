//
//  AddFriendOrGroupViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/1.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation

class AddFriendOrGroupViewController: UIViewController {
    
    @IBOutlet weak var searchFriendTableView: UITableView!
    
    @IBAction func searchFriendAction(_ sender: Any) {
        
        searchFriendTableView.isHidden = !searchFriendTableView.isHidden
        
    }
    
    @IBOutlet var creatOrSearchCompanyGroup: [UIButton]!
    
    @IBAction func createOrSearchGroupAction(_ sender: Any) {
        
        for creatOrSearchCompanyGroupBtn in creatOrSearchCompanyGroup {
            
            creatOrSearchCompanyGroupBtn.isHidden = !creatOrSearchCompanyGroupBtn.isHidden
            
        }
    }
    
    @IBAction func creatCGroupBtn(_ sender: Any) {
        performSegue(withIdentifier: "CreatGroup", sender: nil)
    }
    
    @IBAction func creatFGroupBtn(_ sender: Any) {
        performSegue(withIdentifier: "CreatGroup", sender: nil)
    }
    @IBAction func searchGroupBtn(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchFriendTableView.delegate = self
        
        searchFriendTableView.dataSource = self
        
        
    }
}

extension AddFriendOrGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFriend", for: indexPath) as? SearchFriendTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        cell.searchFriendName.text = "kobe bryant"
//        cell.searchFriendName.layer.cornerRadius = 20
        
        return cell
    }
}
