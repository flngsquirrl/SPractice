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
    @State private var countdown: Bool
    private var callback: () -> Void = {}
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(setTo timeInSeconds: Int, countdown: Bool) {
        self.timeInSeconds = timeInSeconds
        self.countdown = countdown
    }
    
    init(setTo timeInSeconds: Int, countdown: Bool, callback: @escaping () -> Void) {
        self.timeInSeconds = timeInSeconds
        self.countdown = countdown
        self.callback = callback
    }
    
    var secondsPart: Int {
        timeInSeconds % 60
    }
    
    var minutesPart: Int {
        timeInSeconds / 60
    }
    
    var displayInfinity: Bool {
        minutesPart == 60
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 230, height: 70)
            
            Group {
                if displayInfinity {
                    Image(systemName: "infinity")
                        .font(.title.weight(.semibold))
                } else {
                    HStack(spacing: 0) {
                        ClockNumber(number: minutesPart / 10)
                            .padding(2)
                        ClockNumber(number: minutesPart % 10)
                            .padding(2)
                        Text(":")
                            .foregroundColor(.gray)
                            .padding(10)
                        ClockNumber(number: secondsPart / 10)
                            .padding(2)
                        ClockNumber(number: secondsPart % 10)
                            .padding(2)
                    }
                }
            }
            .onReceive(timer) { _ in
                // TODO: check this condition
                if countdown && timeInSeconds == 0 {
                    stopTimer()
                    callback()
                } else {
                    timeInSeconds = countdown ? timeInSeconds - 1 : timeInSeconds + 1
                }
            }
            
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
            ClockView(setTo: 95, countdown: true)
        }
    }
}
