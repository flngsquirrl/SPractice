//
//  ActivityMonitor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.09.22.
//

import Foundation

@MainActor
class ActivityMonitor: ObservableObject {

    @Published var isActive = true

    func activate() {
        isActive = true
    }

    func inactivate() {
        isActive = false
    }
}
