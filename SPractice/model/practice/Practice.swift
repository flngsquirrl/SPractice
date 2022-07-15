//
//  Practice.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import Foundation
import SwiftUI

class Practice: ObservableObject {
    
    let program: PracticeProgram
    let clock: Clock
    let player: Player
    
    var isRunning = false
    @Published var isStarted = false // play was clicked
    @Published var isCompleted = false
    @Published var isCurrentExerciseStarted = false
    
    @Published var currentExerciseIndex = 0
    @Published var currentTaskIndex = 0
    @Published var durationRemaining: Duration
    
    init(for program: PracticeProgram) {
        self.program = program
        
        self.durationRemaining = program.duration
        
        self.player = Player()
        self.clock = Clock()
        
        setToInitialState()
        
        prepareClock()
        preparePlayer()
    }
    
    convenience init(from template: ProgramTemplate) {
        self.init(for: PracticeProgram(from: template))
    }
    
    var isFirstExercise: Bool {
        currentExerciseIndex == 0
    }
    
    var isLastExercise: Bool {
        currentExerciseIndex == program.exercises.count - 1
    }
    
    var currentExercise: PracticeExercise {
        program.exercises[currentExerciseIndex]
    }
    
    public var nextExercise: PracticeExercise? {
        guard currentExerciseIndex < program.exercises.count - 1 else {
            return nil
        }
        
        return program.exercises[currentExerciseIndex + 1]
    }
    
    var isLastTask: Bool {
        currentTaskIndex == currentExercise.tasks.count - 1
    }
    
    var currentTask: Task {
        currentExercise.tasks[currentTaskIndex]
    }
    
    var isDurationRemainingApproximate: Bool {
        program.hasFlowExercises(fromIndex: currentExerciseIndex)
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
    
    func pauseClock() {
        if isRunning {
            stopClock()
        }
    }
    
    func resumeClock() {
        if isRunning {
            startClock()
        }
    }
    
    func restart() {
        reset()
    }
    
    func restartExercise() {
        pause()
        moveToExercise(withIndex: currentExerciseIndex)
    }
    
    func prepare() {
        guard isStarted else { return }
        
        if isCompleted {
            reset()
        }
    }
    
    func reset() {
        setToInitialState()
        resetComponents()
    }
    
    func setToInitialState() {
        isRunning = false
        isStarted = false
        isCompleted = false
        isCurrentExerciseStarted = false
        
        durationRemaining = program.duration
        currentExerciseIndex = 0
        currentTaskIndex = 0
    }
    
    func resetComponents() {
        resetTiming()
        updatePlayerState()
    }
    
    func finish() {
        cancel()
        moveToLastTask()
        resetDurationRemaining()
        isCurrentExerciseStarted = false
        
        if currentExercise.type != .flow {
            clock.resetTime()
        }
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
    
    func moveToExercise(withIndex index: Int) {
        guard index < program.exercises.count else {
            return 
        }
        currentExerciseIndex = index
        onMoveToExercise()
    }
    
    func moveToNextExercise() {
        if isLastExercise {
            finish()
        } else {
            currentExerciseIndex += 1
            onMoveToExercise()
        }
    }
    
    func moveToPreviousExercise() {
        currentExerciseIndex -= 1
        onMoveToExercise()
    }
    
    func onMoveToExercise() {
        isCurrentExerciseStarted = false
        currentTaskIndex = 0
        resetTiming()
        updatePlayerState()
        setDurationRemaining()
    }
    
    func moveToNextTask() {
        currentTaskIndex += 1
        resetTiming()
    }
    
    func moveToLastTask() {
        let lastTaskIndex = currentExercise.tasks.count - 1
        guard currentTaskIndex != lastTaskIndex else {
            return
        }
        currentTaskIndex = lastTaskIndex
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
    
    func prepareClock() {
        clock.onFinished = { self.processCountingFinished() }
        clock.onTick = {
            self.updateDurationRemaining()
            self.isCurrentExerciseStarted = true
        }
        setClock()
    }
    
    func setDurationRemaining() {
        durationRemaining = program.calculateDuration(fromIndex: currentExerciseIndex)
    }
    
    func resetDurationRemaining() {
        if case .known = durationRemaining {
            durationRemaining = .known(0)
        }
    }
    
    func updateDurationRemaining() {
        if currentExercise.type != .flow {
            if case .known(let time) = durationRemaining {
                self.durationRemaining = .known(time - 1)
            }
        }
    }
    
    func setClock() {
        if case .known(let time) = currentTask.duration {
            clock.reset(to: time, isCountdown: true)
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
        player.isPlaying = isRunning
        player.isPlayEnabled = !isRunning && !isCompleted
        player.isPauseEnabled = isRunning && !isCompleted
        player.isBackwardEnabled = !isFirstExercise && !isCompleted
        player.isForwardEnabled = !isCompleted
    }
    
    func preparePlayer() {
        player.onBackwardClicked = moveToPreviousExercise
        player.onForwardClicked = moveToNextExercise
        player.onPlayClicked = run
        player.onPauseClicked = pause
        
        updatePlayerState()
    }
    
}
