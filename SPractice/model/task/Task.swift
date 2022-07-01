//
//  Task.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Task: Identifiable {
    
    let id: UUID
    let type: IntensityType
    let name: String
    let duration: Duration
    
    init(type: IntensityType, name: String, duration: Duration) {
        self.id = UUID()
        self.type = type
        self.name = name
        self.duration = duration
    }
    
    // examples
    static let activity60 = Task(type: .activity, name: "activity", duration: .known(60))
    
    static let restTabataWarmUp = Task(type: .rest, name: "warm-up", duration: .known(10))
    static let activityTabata1 = Task(type: .activity, name: "activity 1", duration: .known(20))
    static let restTabata1 = Task(type: .rest, name: "rest 1", duration: .known(10))
    static let activityTabata2 = Task(type: .activity, name: "activity 2", duration: .known(20))
    static let restTabata2 = Task(type: .rest, name: "rest 2", duration: .known(10))
    static let restTabataCoolDown = Task(type: .rest, name: "cool-down", duration: .known(10))
    
    static let restService10 = Task(type: .rest, name: "rest", duration: .known(10))
    static let activityFlow = Task(type: .activity, name: "activity", duration: .unlimited)
}
