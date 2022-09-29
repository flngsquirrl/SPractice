//
//  SPracticeApp.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI
import Survicate

@main
struct SPracticeApp: App {

    init() {
        SurvicateSdk.shared.initialize()
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.customAccentColor)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
