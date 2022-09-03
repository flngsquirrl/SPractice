//
//  Clock.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import Foundation

@MainActor class Clock: ObservableObject {

    @Published var time: ClockTime
    @Published var isCountdown: Bool

    var onFinished: (() -> Void)?
    var onTick: ((Bool) -> Void)?

    var isTicking = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    private var timerSubscription: Cancellable?

    static let maxMinutesPart = 60
    static let warningTime = 5

    static var stopCountingUpAutomatically: Bool {
        SettingsManager.flowAutoFinishItem.value
    }

    static var maxCountUpTime: Int {
        SettingsManager.flowAutoFinishAfterTime
    }

    // examples
    public static let simpleCountdown = Clock(setTo: 130, isCountdown: true)
    public static let simpleCountup = Clock(setTo: 33, isCountdown: false)

    init(setTo timeInSeconds: Int = 0, isCountdown: Bool = false, onFinished: (() -> Void)? = nil, onTick: ((Bool) -> Void)? = nil) {
        self.time = ClockTime(timeInSeconds: timeInSeconds)
        self.isCountdown = isCountdown
        self.onFinished = onFinished
        self.onTick = onTick
    }

    var countdownFinished: Bool {
        isCountdown && time.isOut
    }

    var setupMax: Int {
        Self.maxCountUpTime
    }

    var countupReachedSetupMax: Bool {
        isCountup && time.timeInSeconds == setupMax - 1
    }

    var countupReachedClockMax: Bool {
        isCountup && time.minutesPart == Self.maxMinutesPart - 1
    }

    var isCountup: Bool {
        !isCountdown
    }

    func processTimerTick() {
        if isCountdown {
            if countdownFinished {
                processCountFinished()
            } else {
                tickClock()
            }
        } else {
            if Self.stopCountingUpAutomatically {
                if countupReachedSetupMax {
                    processCountFinished()
                } else {
                    tickClock()
                }
            } else {
                if !countupReachedClockMax {
                    tickClock()
                }
            }
        }
    }

    func tickClock() {
        if isCountup {
            time.addSecond()
        } else {
            time.substractSecond()
        }

        var withWarning = false
        if isCountdown {
            withWarning = shouldSignalWarning(time: time.timeInSeconds)
        } else {
            if Self.stopCountingUpAutomatically {
                withWarning = shouldSignalWarning(time: setupMax - time.timeInSeconds)
            }
        }
        onTick?(withWarning)
    }

    func shouldSignalWarning(time: Int) -> Bool {
        time <= Self.warningTime
    }

    func processCountFinished() {
        stop()
        if let onFinished = onFinished {
            onFinished()
        }
    }

    func start() {
        if !isTicking {
            timerSubscription = timer.autoconnect()
                .sink { _ in
                    self.processTimerTick()
                }
            isTicking = true
        }
    }

    func stop() {
        timerSubscription?.cancel()
        isTicking = false
    }

    func resetTime() {
        self.time = ClockTime(timeInSeconds: 0)
    }

    func reset(to timeInSeconds: Int = 0, isCountdown: Bool = false) {
        stop()
        self.time = ClockTime(timeInSeconds: timeInSeconds)
        self.isCountdown = isCountdown
    }
}
