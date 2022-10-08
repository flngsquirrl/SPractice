//
//  Resolver.swift
//  SPracticeTests
//
//  Created by Yuliya Charniak on 8.10.22.
//

import Foundation
import Resolver

@testable import SPractice

extension Resolver {

    static var mock = Resolver()

    static func registerMockServices() {
        root = mock

        mock.register { MockTabataSettingsProvider() }
            .implements(TabataSettingsProvider.self)

        mock.register { MockRestSettingsProvider() }
            .implements(RestSettingsProvider.self)

    }
}
