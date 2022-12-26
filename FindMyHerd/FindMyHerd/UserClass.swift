//
//  UserClass.swift
//  FindMyHerd
//
//  Created by Shayna Kaushal on 12/26/22.
//

import Foundation

class User {
    var uid: Int = 0
    var fname: String = ""
    var lname: String = ""
    var email: String = ""
    var pronouns: String = ""
    var state: String = ""          //TODO: make this statemachine/enum equivalent
    
    
    init(uid: Int, fname: String, lname: String, email: String, pronouns: String, state: String) {
        self.uid = uid
        self.fname = fname
        self.lname = lname
        self.email = email
        self.pronouns = pronouns
        self.state = state
    }
}
