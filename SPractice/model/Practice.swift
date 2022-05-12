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
    var isInProgress = false
    var isFinished = false
    
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
        if !isInProgress {
            start()
        }
        
        startClock()
        isRunning = true
        updatePlayerState()
    }
    
    func start() {
        setClock()
        isInProgress = true
    }
    
    func pause() {
        stopClock()
        isRunning = false
        updatePlayerState()
    }
    
    func finish() {
        stopClock()
        isFinished = true
        updatePlayerState()
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
            moveToNextExercise()
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
        player.isPlayEnabled = !isRunning && !isFinished
        player.isPauseEnabled = isRunning && !isFinished
        player.isBackwardEnabled = !isFirstExercise && !isFinished
        player.isForwardEnabled = !isLastExercise && !isFinished
        player.isStopEnabled = isInProgress && !isFinished
    }
    
}
