//
//  UserProfileDataModel.swift
//  RickM+
//
//  Created by RickSun on 2020/2/14.
//  Copyright © 2020 RickSun. All rights reserved.
//

import Foundation
import UIKit


struct Users: Codable {
    var email: String
    var friends: [String]
    var id: String
    var mID: String
    var name: String
    var phoneNumber: String
    var status: String
    var photoURL: String?
    var colleague: Bool
}

