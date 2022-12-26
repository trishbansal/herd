//
//  UserClass.swift
//  FindMyHerd
//
//  Created by Shayna Kaushal on 12/26/22.
//

import Foundation

//import SQLite3

class User {
    var uid: Int = 0
    var fname: String = ""
    var lname: String = ""
    var email: String = ""
    
    init(uid: Int, fname: String, lname: String, email: String) {
        self.uid = uid
        self.fname = fname
        self.lname = lname
        self.email = email
    }
}
