//
//  Task-Sleep.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.11.22.
//

import Foundation

typealias SwiftTask = _Concurrency.Task

extension SwiftTask where Success == Never, Failure == Never {

    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await SwiftTask.sleep(nanoseconds: duration)
    }
}
