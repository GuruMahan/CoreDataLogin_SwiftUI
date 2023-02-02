//
//  CoreDataLoginApp.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import SwiftUI

@main
struct CoreDataLoginApp: App {
   
  
    
    @StateObject private var manager: DataManager = DataManager()
 
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "islogin"){
                DashboardView()
                    .environmentObject(manager)
                      .environment(\.managedObjectContext, manager.container.viewContext)
            }else{
                LoginView()
              .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
            }
               
        }
    }
}
