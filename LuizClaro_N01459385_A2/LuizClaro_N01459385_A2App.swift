//
//  LuizClaro_N01459385_A2App.swift
//  LuizClaro_N01459385_A2
//
//  Created by Luiz Claro on 2022-04-15.
//

import SwiftUI
import Firebase

// MARK: - Creating a project-level Optional object of Firebase User
//var firebaseUser : User = User()

@main
struct LuizClaro_N01459385_A2App: App {
    @State private var showLaunchScreen: Bool = true
    
    // MARK: - Declaring Firebase in init()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView().foregroundColor(.white)
                if showLaunchScreen{
                    LaunchView(showLaunch: $showLaunchScreen).transition(.move(edge: .leading))
                        .statusBar(hidden: true)
                        .foregroundColor(.white)
                }
            }.zIndex(2.0)
        }
    }
}
