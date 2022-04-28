//
//  ClockView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ClockNumber: View {
    var number: Int = 0
    
    var body: some View {
        Text("\(number)")
            .frame(width: 30, height: 50)
            .background(.orange)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .font(.title.weight(.semibold))
            .foregroundStyle(.black)
    }
}

struct ClockView: View {
    
    @State private var timeInSeconds: Int
    @State private var isCountdown: Bool
    
    private var callback: (() -> Void)? = nil
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private static let maxMinutesPart = 60
    private static let maxSecondsPart = 60
    private static let maxReachedImageName = "infinity"
    
    public static let simpleCountdown = ClockView(setTo: 130, isCountdown: true)
    public static let simpleCountup = ClockView(setTo: 33, isCountdown: false)
    
    init(setTo timeInSeconds: Int, isCountdown: Bool) {
        self.timeInSeconds = timeInSeconds
        self.isCountdown = isCountdown
    }
    
    init(setTo timeInSeconds: Int, isCountdown: Bool, callback: @escaping () -> Void) {
        self.timeInSeconds = timeInSeconds
        self.isCountdown = isCountdown
        self.callback = callback
    }
    
    var secondsPart: Int {
        timeInSeconds % ClockView.maxSecondsPart
    }
    
    var minutesPart: Int {
        timeInSeconds / ClockView.maxSecondsPart
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
        !isCountdown && minutesPart == ClockView.maxMinutesPart
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 230, height: 70)
            
            Group {
                if countupReachedMax {
                    Image(systemName: ClockView.maxReachedImageName)
                        .font(.title.weight(.semibold))
                } else {
                    HStack(spacing: 0) {
                        ClockNumber(number: minutesFirstDigit)
                            .padding(2)
                        ClockNumber(number: minutesSecondDigit)
                            .padding(2)
                        Text(":")
                            .foregroundColor(.gray)
                            .padding(10)
                        ClockNumber(number: secondsFirstDigit)
                            .padding(2)
                        ClockNumber(number: secondsSecondDigit)
                            .padding(2)
                    }
                }
            }
            .onReceive(timer) { _ in
                processTimerTick()
            }
            
        }
    }
    
    func processTimerTick() {
        if countdownFinished || countupReachedMax {
            processStopClock()
        } else {
            timeInSeconds = isCountdown ? timeInSeconds - 1 : timeInSeconds + 1
        }
    }
    
    func processStopClock() {
        stopTimer()
        if let callback = callback {
            callback()
        }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            ClockView(setTo: 95, isCountdown: true)
        }
    }
}
