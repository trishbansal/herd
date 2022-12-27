//
//  UserClass.swift
//  FindMyHerd
//
//  Created by Shayna Kaushal on 12/26/22.
//

import Foundation

class User {
    var uid: Int = 0
    var first_name: String = ""
    var last_name: String = ""
    var email: String = ""
    var pronouns: String = ""
    var state: String = ""          //TODO: make this statemachine/enum equivalent
    
    
    init(uid: Int, fname: String, lname: String, email: String, pronouns: String, state: String) {
        self.uid = uid
        self.first_name = fname
        self.last_name = lname
        self.email = email
        self.pronouns = pronouns
        self.state = state
    }
}
