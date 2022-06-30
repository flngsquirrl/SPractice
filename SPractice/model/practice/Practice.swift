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
    let player: Player
    
    var isRunning = false
    var isStarted = false
    var isCompleted = false
    
    @Published var currentExerciseIndex = 0
    @Published var currentTaskIndex = 0
    @Published var durationRemaining: Int?
    
    init(for program: Program) {
        self.program = program
        self.durationRemaining = program.duration
        
        self.player = Player()
        self.clock = Clock()
        
        setToInitialState()
        
        prepareClock()
        preparePlayer()
    }
    
    convenience init(from template: ProgramTemplate) {
        self.init(for: Program(from: template))
    }
    
    var isFirstExercise: Bool {
        currentExerciseIndex == 0
    }
    
    var isLastExercise: Bool {
        currentExerciseIndex == program.exercises.count - 1
    }
    
    var currentExercise: Exercise {
        program.exercises[currentExerciseIndex]
    }
    
    private var previousExercise: Exercise {
        program.exercises[currentExerciseIndex - 1]
    }
    
    public var nextExercise: Exercise? {
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
        
        currentExerciseIndex = 0
        currentTaskIndex = 0
    }
    
    func resetComponents() {
        resetTiming()
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
        setDurationRemaining()
    }
    
    func moveToPreviousExercise() {
        currentExerciseIndex -= 1
        currentTaskIndex = 0
        resetTiming()
        updatePlayerState()
        setDurationRemaining()
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
    
    func prepareClock() {
        clock.onFinished = { self.processCountingFinished() }
        clock.onTick = { self.updateDurationRemaining() }
        setClock()
    }
    
    func setDurationRemaining() {
        durationRemaining = program.calculateDuration(from: currentExerciseIndex)
    }
    
    func updateDurationRemaining() {
        if currentExercise.type != .flow {
            if durationRemaining != nil {
                self.durationRemaining! -= 1
            }
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
        player.isPlaying = isRunning
        player.isPlayEnabled = !isRunning && !isCompleted
        player.isPauseEnabled = isRunning && !isCompleted
        player.isBackwardEnabled = !isFirstExercise && !isCompleted
        player.isForwardEnabled = !isLastExercise && !isCompleted
        player.isStopEnabled = isStarted && !isCompleted
    }
    
    func preparePlayer() {
        player.onBackwardClicked = moveToPreviousExercise
        player.onForwardClicked = moveToNextExercise
        player.onPlayClicked = run
        player.onPauseClicked = pause
        player.onStopClicked = finish
    }
    
}
