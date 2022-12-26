//
//  WalkClass.swift
//  FindMyHerd
//
//  Created by Shayna Kaushal on 12/26/22.
//

import Foundation

class Walk {
    var wid: Int = 0
    var shepherd_uid: Int = 0       //uid of person who starts the walk lol
    
    //TODO: edit datatypes for geodata and datetime
    var start_loc: String = ""      //using str as placeholder
    var end_loc: String = ""        //using str as placeholder  
    var req_time: String = ""       //using str as placeholder
    var start_time: String = ""     //when the walk started so we can time it? [can be removed]
    
    
    init(wid: Int, shepherd_uid: Int, start_loc: String, end_loc: String, req_time: String, start_time: String) {
        self.wid = wid
        self.shepherd_uid = shepherd_uid
        self.start_loc = start_loc
        self.end_loc = end_loc
        self.req_time = req_time
        self.start_time = start_time
    }
}
