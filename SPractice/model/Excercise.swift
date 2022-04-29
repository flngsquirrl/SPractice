//
//  Excercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Excercise {
    let id: UUID
    let type: ExcerciseType
    let name: String
    let tasks: Array<Task>
    
    static let catCow = Excercise(id: UUID(), type: .timer, name: "Cat-Cow", tasks: [Task.activity60])
    static let surjaNamascar = Excercise(id: UUID(), type: .flow, name: "Surja Namascar", tasks: [Task.activityFlow])
    static let vasihsthasana = Excercise(id: UUID(), type: .tabata, name: "Vasihsthasana", tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = Excercise(id: UUID(), type: .timer, name: "Rest", tasks: [Task.restService10])

}
