//
//  functions.swift
//  FindMyHerd
//
//  Created by Trisha Bansal on 12/19/22.
//

import Foundation
import SQLite

//Function 1: setUserWalkStart
//Input: username, lat, long
//Function: adds starting lat, long location to database (user walk)
func setUserWalkStart(username: String, lat: Float, long: Float) {
    let insert = userWalks.insert(username <- username, start_loc <- (lat, long))
    try db.run(insert)
}

//Function 2: setUserWalkEnd
//Input: username, lat, long
//Function: adds ending lat, long location to database (user walk)
func setUserWalkEnd(username: String, lat: Float, long: Float) {
    let insert = userWalks.insert(username <- username, end_loc <- (lat, long))
    try db.run(insert)
}

//Function 3: updateUserWalkStatus
//Input: username, state
//Function: updates the state in database (user walk)
func updateUserWalkStatus(username: String, state: String) {
    let insert = userWalks.insert(username <- username, state <- state)
    try db.run(insert)
}

//Function 4: setUserWalkTime
//Input: username, time
//Function: adds user desired time to database (userwalk)
func setUserWalkTime(username: String, time_hour: Int, time_min: Int) {
    //we get time as 1:00, 1:10, 1:15, etc in String form, covert to military time 4 digit int and store in database ya?
    //so 1:10pm is entered as time_hour = 1, time_min = 10 == 1310
    let militaryTime = Int(String(format: "%02d", time_hour) + String(format: "%02d", time_min))
    let insert = userWalks.insert(username <- username, time <- militaryTime)
    try db.run(insert)
}

