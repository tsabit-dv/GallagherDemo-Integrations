//
//  GallagherDemoApp.swift
//  GallagherDemo
//
//  Created by USER on 9/21/1447 AH.
//

import SwiftUI

@main
struct GallagherDemoApp: App {
    
    @State private var showMainView = false
    
    var body: some Scene {
        WindowGroup {
            if showMainView {
                MainView()
            } else {
                SplashView(showMainView: $showMainView)
            }
        }
    }
}
