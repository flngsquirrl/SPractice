//
//  ViewRouter.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import Foundation

enum ViewType {
    case home
    case onboarding
}

class ViewRouter: ObservableObject {

    @Published var currentView = ViewType.onboarding

    func goHome() {
        currentView = .home
    }

}
