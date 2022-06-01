//
//  Task.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Task {
    
    enum TaskType {
        case activity
        case rest
    }
    
    let id: UUID
    let type: TaskType
    let name: String
    let duration: Int?
    
    init(type: TaskType, name: String, duration: Int? = nil) {
        self.id = UUID()
        self.type = type
        self.name = name
        self.duration = duration
    }
    
    static let activity60 = Task(type: .activity, name: "activity", duration: 60)
    
    static let restTabataWarmUp = Task(type: .rest, name: "warm-up", duration: 10)
    static let activityTabata1 = Task(type: .activity, name: "activity 1", duration: 20)
    static let restTabata1 = Task(type: .rest, name: "rest 1", duration: 10)
    static let activityTabata2 = Task(type: .activity, name: "activity 2", duration: 20)
    static let restTabata2 = Task(type: .rest, name: "rest 2", duration: 10)
    static let restTabataCoolDown = Task(type: .rest, name: "cool-down", duration: 10)
    
    static let restService10 = Task(type: .rest, name: "rest", duration: 10)
    static let activityFlow = Task(type: .activity, name: "activity")
}
