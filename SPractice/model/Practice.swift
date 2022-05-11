//
//  Practice.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import Foundation

struct Practice {
    
    let program: Program
    
    var isRunning = false
    var isInProgress = false
    var isFinished = false
    
    init(for program: Program) {
        self.program = program
    }
    
    var currentExerciseIndex = 0
    var currentTaskIndex = 0
    
    var isFirstExercise: Bool {
        currentExerciseIndex == 0
    }
    
    var isLastExercise: Bool {
        currentExerciseIndex == program.exercises.count - 1
    }
    
    var currentExercise: Exercise {
        program.exercises[currentExerciseIndex]
    }
    
    var isLastTask: Bool {
        currentTaskIndex == currentExercise.tasks.count - 1
    }
    
    var currentTask: Task {
        currentExercise.tasks[currentTaskIndex]
    }
    
    mutating func start() {
        isRunning = true
        isInProgress = true
    }
    
    mutating func pause() {
        isRunning = false
    }
    
    mutating func finish() {
        isFinished = true
    }
    
    mutating func moveToNextExercise() {
        currentExerciseIndex += 1
    }
    
    mutating func moveToPreviousExercise() {
        currentExerciseIndex -= 1
    }
}
