//
//  ViewRouter.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import Foundation

@MainActor
class ViewRouter: ObservableObject {

    enum ViewType {
        case home
        case onboarding
        case welcome
    }

    enum UserDefaultsKey: String {
        case isOnBoard
    }

    @Published var currentView: ViewType?

    init() {
        route()
    }

    func route() {
        if isOnBoard {
            currentView = .welcome
        } else {
            currentView = .onboarding
        }
    }

    private var isOnBoard: Bool {
        UserDefaults.standard.bool(forKey: UserDefaultsKey.isOnBoard.rawValue)
    }

    func goHome() {
        currentView = .home
    }

    func onboard() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.isOnBoard.rawValue)
        goHome()
    }

}
