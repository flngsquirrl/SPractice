//
//  InfoManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.09.22.
//

import Foundation

enum InfoPage {
    case example
    case execiseType
    case exerciseDuration
    case exerciseIntensity
    case programDuration
}

@MainActor class InfoController: ObservableObject {

    @Published var showInfo: Bool = false
    var page: InfoPage?

    func showInfo(for page: InfoPage) {
        showInfo = true
        self.page = page
    }

    func hideInfo() {
        showInfo = false
    }
}
