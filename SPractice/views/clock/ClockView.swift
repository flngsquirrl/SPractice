//
//  ClockView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ClockView: View {
    
    @StateObject var clock: Clock
    
    private static let countupImageName = "infinity"
    
    private let mainFont: Font = .largeTitle.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)
    
    public static let simpleCountdown = ClockView(clock: Clock.simpleCountdown)
    public static let simpleCountup = ClockView(clock: Clock.simpleCountup)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.lightForeground)
                
                Group {
                    if clock.isCountup {
                        ZStack{
                            Image(systemName: ClockView.countupImageName)
                                .font(mainFont)
                                .foregroundColor(.darkBright)
                                .scaleEffect(2)
                            HStack {
                                if (clock.isCountingUp) {
                                    Text("\(clock.minutesFirstDigit)\(clock.minutesSecondDigit):\(clock.secondsFirstDigit)\(clock.secondsSecondDigit)")
                                        .foregroundColor(.darkBright)
                                        .font(noteFont)
                                }
                            }
                            .offset(x: geo.size.width * 0.37, y: geo.size.height * 0.25)
                        }
                    } else {
                        HStack(spacing: 4) {
                            ClockNumber(number: clock.minutesFirstDigit)
                            ClockNumber(number: clock.minutesSecondDigit)
                            Text(":")
                                .foregroundColor(.darkForeground)
                                .font(mainFont)
                                .padding(8)
                            ClockNumber(number: clock.secondsFirstDigit)
                            ClockNumber(number: clock.secondsSecondDigit)
                        }
                    }
                }
            }
        }
    }
    
    struct ClockNumber: View {
        var number: Int = 0
        
        var body: some View {
            Text("\(number)")
                .frame(width: 50, height: 80)
                .background(.darkBright)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.lightForeground)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightBright
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
