//
//  TodoItem.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import UIKit
import SwiftUI

/// A simple model to keep track of tasks
class TodoItem: NSObject, ObservableObject, Identifiable {
    
    var email: String
    var password: String
    
    init(task: String) {
        email = task
        password = task
        
    }
}
