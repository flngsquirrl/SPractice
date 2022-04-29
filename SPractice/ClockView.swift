//
//  ClockView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import Combine
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
    
    @State var timeInSeconds: Int
    @State var isCountdown: Bool
    var onFinished: (() -> Void)?
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerSubscription: Cancellable?
    
    private static let maxMinutesPart = 60
    private static let maxSecondsPart = 60
    private static let countupImageName = "infinity"
    
    public static let simpleCountdown = ClockView(timeInSeconds: 130, isCountdown: true)
    public static let simpleCountup = ClockView(timeInSeconds: 33, isCountdown: false)
    
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
        isCountup && minutesPart == ClockView.maxMinutesPart
    }
    
    var isCountup: Bool {
        !isCountdown
    }
    
    var isCountingUp: Bool {
        !countupReachedMax
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 230, height: 70)
            
            Group {
                if isCountup {
                    ZStack{
                        Image(systemName: ClockView.countupImageName)
                            .font(.title.weight(.semibold))
                        HStack {
                            Spacer()
                            Spacer()
                            if (isCountingUp) {
                                Text("\(minutesFirstDigit)\(minutesSecondDigit):\(secondsFirstDigit)\(secondsSecondDigit)")
                            }
                            Spacer()
                        }
                    }
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
    
    func start() -> some View {
        timerSubscription = timer.connect()
        return self
    }
    
    func stop() -> some View {
        timerSubscription?.cancel()
        return self
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            ClockView.simpleCountup
        }
    }
}
