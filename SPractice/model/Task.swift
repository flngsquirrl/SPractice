//
//  Task.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Task {
    let id = UUID()
    var type: TaskType
    var name: String
    var duration: Int?
    
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

enum TaskType {
    case activity
    case rest
}
