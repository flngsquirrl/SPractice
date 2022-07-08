//
//  SPracticeApp.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

@main
struct SPracticeApp: App {
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.customAccentColor)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
