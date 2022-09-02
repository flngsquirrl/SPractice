//
//  Task.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Task: Identifiable {

    let id: UUID
    let intensity: Intensity
    let name: String
    let duration: Duration

    init(intensity: Intensity, name: String, duration: Duration) {
        self.id = UUID()
        self.intensity = intensity
        self.name = name
        self.duration = duration
    }

    // examples
    static let activity60 = Task(intensity: .activity, name: "activity", duration: .known(60))

    static let restTabataWarmUp = Task(intensity: .rest, name: "warm-up", duration: .known(10))
    static let activityTabata1 = Task(intensity: .activity, name: "activity 1", duration: .known(20))
    static let restTabata1 = Task(intensity: .rest, name: "rest 1", duration: .known(10))
    static let activityTabata2 = Task(intensity: .activity, name: "activity 2", duration: .known(20))
    static let restTabata2 = Task(intensity: .rest, name: "rest 2", duration: .known(10))
    static let restTabataCoolDown = Task(intensity: .rest, name: "cool-down", duration: .known(10))

    static let restTimer = Task(intensity: .rest, name: "rest", duration: .known(10))
    static let activityFlow = Task(intensity: .activity, name: "activity", duration: .unlimited)
}
