//
//  DataManager.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import Foundation

import CoreData
/// Main data manager to handle the todo items
class DataManager: NSObject, ObservableObject {
    /// Dynamic properties that the UI will react to
    @Published var todoItems: [TodoItem] = [TodoItem]()
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
