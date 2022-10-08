//
//  MockRestSettingsProvider.swift
//  SPracticeTests
//
//  Created by Yuliya Charniak on 8.10.22.
//

import Foundation

@testable import SPractice

struct MockRestSettingsProvider: RestSettingsProvider {

    static let testRestName = "test rest"
    static let testRestDuration = 3

    var restName: String {
        Self.testRestName
    }

    var restDuration: Int {
        Self.testRestDuration
    }

}
