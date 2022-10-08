//
//  Practice.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import AVFoundation
import Foundation
import Resolver
import SwiftUI

@MainActor class Practice: ObservableObject {

    let program: PracticeProgram
    let clock: Clock
    let player: Player

    let programService = ProgramService()
    let practiceService = PracticeService()

    @Injected var audioPlayer: AudioPlayer

    @Published var isSoundOn: Bool
    var usePauses: Bool

    var isRunning = false
    @Published var isStarted = false // play was clicked
    @Published var isCompleted = false
    @Published var isCurrentExerciseStarted = false

    @Published var currentExerciseIndex = 0
    @Published var currentTaskIndex = 0
    @Published var durationRemaining: Duration

    init(for template: ProgramTemplate, with settings: PracticeSettings) {
        self.program = practiceService.prepareForPractice(template, useRest: settings.addRestIntervals)
        self.usePauses = settings.pauseAfterExercise
        self.isSoundOn = settings.playSounds

        self.durationRemaining = programService.calculateDuration(of: program)

        self.player = Player()
        self.clock = Clock()

        setToInitialState()

        prepareClock()
        preparePlayer()
    }

    var remainingExercises: [PracticeExercise] {
        Array(program.exercises[currentExerciseIndex...])
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
        let runAfterReset = isRunning
        reset()
        processRunAfterReset(shouldStart: runAfterReset)
    }

    func restartExercise() {
        let runAfterReset = isRunning
        pause()
        moveToExercise(withIndex: currentExerciseIndex)
        processRunAfterReset(shouldStart: runAfterReset)
    }

    func processRunAfterReset(shouldStart: Bool) {
        if shouldStart {
            run()
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

        durationRemaining = programService.calculateDuration(of: program)
        currentExerciseIndex = 0
        currentTaskIndex = 0
    }

    func resetComponents() {
        resetTiming()
        updatePlayerState()
    }

    func finish() {
        stopClock()
        moveToLastTask()
        resetDurationRemaining()
        isCurrentExerciseStarted = false

        if currentExercise.type != .flow {
            clock.resetTime()
        }
        isCompleted = true
        updatePlayerState()
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

        if usePauses {
            pause()
        }
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
        updateDurationRemaining()

        if isSoundOn {
            playSound(isEnd: true)
        }

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
        clock.onFinished = { [weak self] in self?.processCountingFinished() }
        clock.onTick = { [weak self] in self?.onClockTick(withWarning: $0) }
        setClock()
    }

    func onClockTick(withWarning: Bool) {
        updateDurationRemaining()

        if withWarning && isSoundOn {
            playSound()
        }

        isCurrentExerciseStarted = true
    }

    func toggleSound() {
        isSoundOn.toggle()
    }

    func playSound(isEnd: Bool = false) {
        if isEnd {
            playEndSound()
        } else {
            audioPlayer.play(type: .taskCountdown)
        }
    }

    func playEndSound() {
        var soundType: SoundType
        if isLastExercise && isLastTask {
            soundType = .endOfPractice
        } else if isLastTask {
            soundType = .endOfExercise
        } else {
            soundType = .endOfTask
        }
        audioPlayer.play(type: soundType)
    }

    func setDurationRemaining() {
        durationRemaining = programService.calculateDuration(of: remainingExercises)
    }

    func resetDurationRemaining() {
        if case .known = durationRemaining {
            durationRemaining = .known(0)
        }
    }

    func updateDurationRemaining() {
        if currentExercise.type != .flow {
            if case .known(let time) = durationRemaining {
                durationRemaining = .known(time - 1)
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
        manageIdleTimer(disabled: true)
        clock.start()
    }

    func stopClock() {
        manageIdleTimer(disabled: false)
        clock.stop()
    }

    func manageIdleTimer(disabled: Bool) {
        UIApplication.shared.isIdleTimerDisabled = disabled
    }

    func updatePlayerState() {
        player.isPlaying = isRunning
        player.isPlayEnabled = !isRunning && !isCompleted
        player.isPauseEnabled = isRunning && !isCompleted
        player.isBackwardEnabled = !isFirstExercise && !isCompleted
        player.isForwardEnabled = !isCompleted
    }

    func preparePlayer() {
        player.onBackwardClicked = { [weak self] in self?.moveToPreviousExercise() }
        player.onForwardClicked = { [weak self] in self?.moveToNextExercise() }
        player.onPlayClicked = { [weak self] in self?.run() }
        player.onPauseClicked = { [weak self] in self?.pause() }

        updatePlayerState()
    }

}
