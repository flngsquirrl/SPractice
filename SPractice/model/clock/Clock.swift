//
//  Clock.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import Foundation

class Clock: ObservableObject {
    
    @Published var time: ClockTime
    @Published var isCountdown: Bool
    
    var onFinished: (() -> Void)?
    var onTick: (() -> Void)?
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    private var timerSubscription: Cancellable?
    
    static let maxMinutesPart = 60
    
    // examples
    public static let simpleCountdown = Clock(setTo: 130, isCountdown: true)
    public static let simpleCountup = Clock(setTo: 33, isCountdown: false)
    
    init(setTo timeInSeconds: Int = 0, isCountdown: Bool = false, onFinished: (() -> Void)? = nil, onTick: (() -> Void)? = nil) {
        self.time = ClockTime(timeInSeconds: timeInSeconds)
        self.isCountdown = isCountdown
        self.onFinished = onFinished
        self.onTick = onTick
    }
    
    var countdownFinished: Bool {
        isCountdown && time.isOut
    }
    
    var countupReachedMax: Bool {
        isCountup && time.minutesPart == Self.maxMinutesPart
    }
    
    var isCountup: Bool {
        !isCountdown
    }
    
    func processTimerTick() {
        if countdownFinished || countupReachedMax {
            processCountFinished()
        } else {
            if isCountdown {
                time.substractSecond()
            } else {
                time.addSecond()
            }
            onTick?()
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
        self.time = ClockTime(timeInSeconds: timeInSeconds)
        self.isCountdown = isCountdown
    }
}
