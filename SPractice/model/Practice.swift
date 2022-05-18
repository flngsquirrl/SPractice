//
//  Practice.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import Foundation

class Practice: ObservableObject {
    
    let program: Program
    let clock: Clock
    var player: Player
    
    var isRunning = false
    var isStarted = false
    var isCompleted = false
    
    init(for program: Program) {
        self.program = program
        self.clock = Clock()
        self.player = Player()
        
        clock.onFinished = { self.processCountingFinished() }
        setClock()
    }
    
    @Published var currentExerciseIndex = 0
    @Published var currentTaskIndex = 0
    
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
    
    func run() {
        if !isStarted {
            start()
        }
        
        startClock()
        isRunning = true
        updatePlayerState()
    }
    
    func start() {
        setClock()
        isStarted = true
    }
    
    func pause() {
        stopClock()
        isRunning = false
        updatePlayerState()
    }
    
    func finish() {
        cancel()
        isCompleted = true
        updatePlayerState()
    }
    
    func cancel() {
        stopClock()
    }
    
    func resetTiming() {
        stopClock()
        setClock()
        
        if isRunning {
            startClock()
        }
    }
    
    func moveToNextExercise() {
        currentExerciseIndex += 1
        currentTaskIndex = 0
        resetTiming()
        updatePlayerState()
    }
    
    func moveToPreviousExercise() {
        currentExerciseIndex -= 1
        currentTaskIndex = 0
        resetTiming()
        updatePlayerState()
    }
    
    func moveToNextTask() {
        currentTaskIndex += 1
        resetTiming()
    }
    
    func processCountingFinished() {
        if isLastTask {
            if isLastExercise {
                finish()
            } else {
                moveToNextExercise()
            }
        } else {
            moveToNextTask()
        }
    }
    
    func setClock() {
        if let duration = currentTask.duration {
            clock.reset(to: duration, isCountdown: true)
        } else {
            clock.reset()
        }
    }
    
    func startClock() {
        clock.start()
    }
    
    func stopClock() {
        clock.stop()
    }
    
    func updatePlayerState() {
        player.isPlayEnabled = !isRunning && !isCompleted
        player.isPauseEnabled = isRunning && !isCompleted
        player.isBackwardEnabled = !isFirstExercise && !isCompleted
        player.isForwardEnabled = !isLastExercise && !isCompleted
        player.isStopEnabled = isStarted && !isCompleted
    }
    
}
