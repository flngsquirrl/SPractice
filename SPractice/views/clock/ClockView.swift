//
//  ClockView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ClockView: View {
    
    @ObservedObject var clock: Clock
    
    private static let countupImageName = "infinity"
    
    private let mainFont: Font = .largeTitle.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)
    
    public static let simpleCountdown = ClockView(clock: Clock.simpleCountdown)
    public static let simpleCountup = ClockView(clock: Clock.simpleCountup)
    
    var body: some View {
        GeometryReader { geo in
            Group {
                if clock.isCountup {
                    ZStack {
                        Image(systemName: ClockView.countupImageName)
                            .font(mainFont)
                            .foregroundColor(.darkOrange)
                            .scaleEffect(2)
                        
                            if (clock.isCountingUp) {
                                Text("\(clock.minutesFirstDigit)\(clock.minutesSecondDigit):\(clock.secondsFirstDigit)\(clock.secondsSecondDigit)")
                                    .foregroundColor(.darkOrange)
                                    .font(noteFont)
                                    .offset(x: geo.size.width * 0.37, y: geo.size.height * 0.25)
                            }
                     }
                } else {
                    HStack(spacing: 4) {
                        ClockNumber(number: clock.minutesFirstDigit)
                        ClockNumber(number: clock.minutesSecondDigit)
                        Text(":")
                            .foregroundColor(.darkOrange)
                            .font(mainFont)
                            .padding(8)
                        ClockNumber(number: clock.secondsFirstDigit)
                        ClockNumber(number: clock.secondsSecondDigit)
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .background(.creamy)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    struct ClockNumber: View {
        var number: Int = 0
        
        var body: some View {
            Text("\(number)")
                .frame(width: 50, height: 80)
                .background(.darkOrange)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.creamy)
            
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightOrange
                .ignoresSafeArea()
            VStack {
                ClockView.simpleCountup
                    .frame(width: 320, height: 120)
                ClockView.simpleCountdown
                    .frame(width: 320, height: 120)
            }
        }
    }
}
