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

//Function 5: matchUserToWalk
//Input: one userWalk, db of Walks
//Function: deletes the given userWalk from db and adds the corresponding user to a Walk
func matchUserToWalk(userwalk: UserWalk, walks: [Walk], radius: Int) {
    var start_matches: [(Float, Float)] = []
    var end_matches: [(Float, Float)] = []
    for (latitude, longitude, walk_id) in walks.start_loc {
        let distance = getDistance(lat: userwalk.start_loc[0], lon: userwalk.start_loc[1], lat2: latitude, lon2: longitude)
        if distance <= radius {
            start_matches.append(walk_id)
        }
    }
    for (latitude, longitude, walk_id) in walks.end_loc {
        let distance = getDistance(lat: userwalk.end_loc[0], lon: userwalk.end_loc[1], lat2: latitude, lon2: longitude)
        if distance <= radius {
            end_matches.append(walk_id)
        }
    }
    return Set(start_matches).union(Set(end_matches))
    //will need to add guardrails --> if no union is found increase radius and try again?
}

//Function 6: getDistance
//Input: 2 lats and longs
//Output: distance
func getDistance(lat: Float, lon: Float, lat2: Float, lon2: Float) {
    //There is a way to do this that is front end and more accurate --> like actually between the points, lets discuss
}
