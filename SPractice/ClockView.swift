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
    
    @StateObject var clock: Clock
    
    private static let countupImageName = "infinity"
    
    public static let simpleCountdown = ClockView(clock: Clock.simpleCountdown)
    public static let simpleCountup = ClockView(clock: Clock.simpleCountup)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 230, height: 70)
            
            Group {
                if clock.isCountup {
                    ZStack{
                        Image(systemName: ClockView.countupImageName)
                            .font(.title.weight(.semibold))
                        HStack {
                            Spacer()
                            Spacer()
                            if (clock.isCountingUp) {
                                Text("\(clock.minutesFirstDigit)\(clock.minutesSecondDigit):\(clock.secondsFirstDigit)\(clock.secondsSecondDigit)")
                            }
                            Spacer()
                        }
                    }
                } else {
                    HStack(spacing: 0) {
                        ClockNumber(number: clock.minutesFirstDigit)
                            .padding(2)
                        ClockNumber(number: clock.minutesSecondDigit)
                            .padding(2)
                        Text(":")
                            .foregroundColor(.gray)
                            .padding(10)
                        ClockNumber(number: clock.secondsFirstDigit)
                            .padding(2)
                        ClockNumber(number: clock.secondsSecondDigit)
                            .padding(2)
                    }
                }
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            VStack {
                ClockView.simpleCountup
                ClockView.simpleCountdown
            }
        }
    }
}
