//
//  TaskList.swift
//  to_do_list_realm
//
//  Created by Petar Perich on 27.04.2021.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @objc dynamic var task = ""
    @objc dynamic var completed = false 
}
