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
  //  var confirmpassword: String
   // @Published var isCompleted: Bool = false
    
    init(task: String) {
        email = task
        password = task
        
    }
}
