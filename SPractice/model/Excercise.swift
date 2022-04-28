//
//  Excercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Excercise {
    let id = UUID()
    var type: ExcerciseType
    var name: String
    var isService: Bool = false
    var tasks: Array<Task>
    
    static let catCow = Excercise(type: .timer, name: "Cat-Cow", tasks: [Task.activity60])
    static let surjaNamascar = Excercise(type: .flow, name: "Surja Namascar", tasks: [Task.activityFlow])
    static let vasihsthasana = Excercise(type: .tabata, name: "Vasihsthasana", tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = Excercise(type: .timer, name: "Rest", isService: true, tasks: [Task.restService10])

}

enum ExcerciseType: String {
    case flow
    case timer
    case tabata
}
