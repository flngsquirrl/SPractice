//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Exercise {
    
    enum ExerciseType: String, CaseIterable {
        case flow
        case timer
        case tabata;
        
        var imageName: String {
            switch self {
            case .flow:
                return "heart.circle.fill"
            case .timer:
                return "clock.fill"
            case .tabata:
                return "t.circle.fill"
            }
        }
    }
    
    let id: UUID
    let type: ExerciseType
    let name: String
    let tasks: Array<Task>
    
    static let catCow = Exercise(id: UUID(), type: .timer, name: "Cat-Cow", tasks: [Task.activity60])
    static let surjaNamascar = Exercise(id: UUID(), type: .flow, name: "Surja Namascar", tasks: [Task.activityFlow])
    static let vasihsthasana = Exercise(id: UUID(), type: .tabata, name: "Vasihsthasana", tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = Exercise(id: UUID(), type: .timer, name: "Rest", tasks: [Task.restService10])
}
