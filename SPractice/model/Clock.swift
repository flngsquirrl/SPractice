//
//  Clock.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import Foundation

class Clock: ObservableObject {
    
    @Published var timeInSeconds: Int
    @Published var isCountdown: Bool
    
    var onFinished: (() -> Void)?
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    private var timerSubscription: Cancellable?
    
    private static let maxMinutesPart = 60
    private static let maxSecondsPart = 60
    
    public static let simpleCountdown = Clock(setTo: 130)
    public static let simpleCountup = Clock(setTo: 33, isCountdown: false)
    
    init(setTo timeInSeconds: Int = 0, isCountdown: Bool = false, onFinished: (() -> Void)? = nil) {
        self.timeInSeconds = timeInSeconds
        self.isCountdown = isCountdown
        self.onFinished = onFinished
    }
    
    var secondsPart: Int {
        timeInSeconds % Clock.maxSecondsPart
    }
    
    var minutesPart: Int {
        timeInSeconds / Clock.maxSecondsPart
    }
    
    var minutesFirstDigit: Int {
        minutesPart / 10
    }
    
    var minutesSecondDigit: Int {
        minutesPart % 10
    }
    
    var secondsFirstDigit: Int {
        secondsPart / 10
    }
    
    var secondsSecondDigit: Int {
        secondsPart % 10
    }
    
    var countdownFinished: Bool {
        isCountdown && timeInSeconds == 0
    }
    
    var countupReachedMax: Bool {
        isCountup && minutesPart == Clock.maxMinutesPart
    }
    
    var isCountup: Bool {
        !isCountdown
    }
    
    var isCountingUp: Bool {
        !countupReachedMax
    }
    
    func processTimerTick() {
        if countdownFinished || countupReachedMax {
            processCountFinished()
        } else {
            timeInSeconds = isCountdown ? timeInSeconds - 1 : timeInSeconds + 1
        }
    }
    
    func processCountFinished() {
        stop()
        if let onFinished = onFinished {
            onFinished()
        }
    }
    
    func start() {
        timerSubscription = timer.autoconnect()
            .sink { _ in
                self.processTimerTick()
            }
    }
    
    func stop() {
        timerSubscription?.cancel()
    }
    
    func reset(to timeInSeconds: Int = 0, isCountdown: Bool = false) {
        stop()
        self.timeInSeconds = timeInSeconds
        self.isCountdown = isCountdown
    }
}
