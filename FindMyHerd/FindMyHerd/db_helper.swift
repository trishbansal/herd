//
//  dbHelper.swift
//  FindMyHerd
//
//  Created by Shayna Kaushal on 12/26/22.
//

import Foundation
import SQLite3

class dbHelper {
    init() {
        db = openDatabase()
        create_user_table()
        create_walk_table()
    }
    
//    TODO: edit class names; make new class names; edit/make attribute names
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }

    
    //TODO: make this generic - want to use vars not names!! --> \(variable)

    //create table:
    var user_table_cmd = "CREATE TABLE IF NOT EXISTS user (uid INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, pronouns TEXT, state TEXT);"

    var walk_table_cmd = "CREATE TABLE IF NOT EXISTS walk (wid INTEGER PRIMARY KEY, shepherd_uid INTEGER, start_loc TEXT, end_loc TEXT, req_time TEXT, start_time TEXT, walk_state TEXT);"
    
    //TODO: can add param to check which table to be created and make conditional block for create table fns
    func create_user_table() {
        let createTableString = user_table_cmd
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("user table created.")
            } else {
                print("user table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func create_walk_table() {
        let createTableString = walk_table_cmd
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("walk table created.")
            } else {
                print("walk table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    //TODO: !!
    
//    var uid: Int = 0
//    var first_name: String = ""
//    var last_name: String = ""
//    var email: String = ""
//    var pronouns: String = ""
//    var state: String = ""
//    (uid, first_name, last_name, email, pronouns, state)
    
//    func insert_user(id:Int, name:String, age:Int)
    
    func insert_user(uid: Int, first_name: String, last_name: String, email: String, pronouns: String, state: String) {
        let users = read_user()
        for x in users
        {
            if x.uid == uid {
                return
            }
        }
        let insertStatementString = "INSERT INTO user (uid, first_name, last_name, email, pronouns, state) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(uid))
            sqlite3_bind_text(insertStatement, 2, (first_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (last_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (pronouns as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (state as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement for user table could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
//    var wid: Int = 0
//    var shepherd_uid: Int = 0
//    var start_loc: String = ""
//    var end_loc: String = ""
//    var req_time: String = ""
//    var start_time: String = ""
//    var walk_state: String = ""
//    (wid, shepherd_uid, start_loc, end_loc, req_time, start_time, walk_state)
    
    //TODO: use datetime object!!! [https://stackoverflow.com/questions/49143444/swift-sqlite-database-how-to-insert-date-field]
    func insert_walk(wid: Int, shepherd_uid: Int, start_loc: String, end_loc: String, req_time: String, start_time: String, walk_state: String) {
        let walks = read_walk()
        for y in walks
        {
            if y.wid == wid {
                return
            }
        }
        let insertStatementString = "INSERT INTO walk (wid, shepherd_uid, start_loc, end_loc, req_time, start_time, walk_state) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(wid))
            sqlite3_bind_int(insertStatement, 2, Int32(shepherd_uid))
            sqlite3_bind_text(insertStatement, 3, (start_loc as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (end_loc as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (req_time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (start_time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (walk_state as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement for walk table could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    func read_user() -> [User] {
        let queryStatementString = "SELECT * FROM user;"
        var queryStatement: OpaquePointer? = nil
        var psns : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let year = sqlite3_column_int(queryStatement, 2)
                psns.append(User(uid: <#T##Int#>, fname: <#T##String#>, lname: <#T##String#>, email: <#T##String#>, pronouns: <#T##String#>, state: <#T##String#>))
//                print("Query Result:")
//                print("\(id) | \(name) | \(year)")
            }
        } else {
            print("SELECT statement for user table could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func read_walk() -> [Walk] {
        let queryStatementString = "SELECT * FROM walk;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Walk] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let year = sqlite3_column_int(queryStatement, 2)
                psns.append(Walk(wid: <#T##Int#>, shepherd_uid: <#T##Int#>, start_loc: <#T##String#>, end_loc: <#T##String#>, req_time: <#T##String#>, start_time: <#T##String#>, walk_state: <#T##String#>))
//                print("Query Result:")
//                print("\(id) | \(name) | \(year)")
            }
        } else {
            print("SELECT statement for walk table could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    
    func delete_user_row_by_uid(uid: Int) {
        let deleteStatementStirng = "DELETE FROM user WHERE uid = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(uid))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement for user table could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
    func delete_walk_row_by_wid(wid: Int) {
        let deleteStatementStirng = "DELETE FROM walk WHERE wid = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(wid))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement for walk table could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    //used to delete all walks started by a certain user; TODO: is this right lol??
    func delete_walk_row_by_uid(uid: Int) {
        let deleteStatementStirng = "DELETE FROM walk WHERE uid = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(uid))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement for walk table could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
//    func insert(id:Int, name:String, age:Int)
//    {
//        let persons = read()
//        for p in persons
//        {
//            if p.id == id
//            {
//                return
//            }
//        }
//        let insertStatementString = "INSERT INTO person (Id, name, age) VALUES (?, ?, ?);"
//        var insertStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(insertStatement, 1, Int32(id))
//            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(insertStatement, 3, Int32(age))
//
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
//        } else {
//            print("INSERT statement could not be prepared.")
//        }
//        sqlite3_finalize(insertStatement)
//    }
    
    
//    func read() -> [Person] {
//        let queryStatementString = "SELECT * FROM person;"
//        var queryStatement: OpaquePointer? = nil
//        var psns : [Person] = []
//        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                let id = sqlite3_column_int(queryStatement, 0)
//                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let year = sqlite3_column_int(queryStatement, 2)
//                psns.append(Person(id: Int(id), name: name, age: Int(year)))
//                print("Query Result:")
//                print("\(id) | \(name) | \(year)")
//            }
//        } else {
//            print("SELECT statement could not be prepared")
//        }
//        sqlite3_finalize(queryStatement)
//        return psns
//    }
    
    
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
    
    
    
    
}
