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
    
    private static let mainFont: Font = .largeTitle.weight(.semibold)
    private static let noteFont: Font = .body.weight(.semibold)
    
    private static let elementColor: Color = .lightOrange
    private static let textColor: Color = .creamy
    private static let backgroundColor: Color = Color(UIColor.tertiarySystemBackground)
    
    public static let simpleCountdown = ClockView(clock: Clock.simpleCountdown)
    public static let simpleCountup = ClockView(clock: Clock.simpleCountup)
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Group {
                if clock.isCountup {
                    Image(systemName: ClockView.countupImageName)
                        .foregroundColor(ClockView.elementColor)
                        .scaleEffect(2)
                } else {
                    HStack {
                        ClockNumber(number: clock.time.minutesFirstDigit)
                        ClockNumber(number: clock.time.minutesSecondDigit)
                        Text(":")
                            .foregroundColor(ClockView.elementColor)
                        ClockNumber(number: clock.time.secondsFirstDigit)
                        ClockNumber(number: clock.time.secondsSecondDigit)
                    }
                    .foregroundColor(ClockView.textColor)
                }
            }
            .font(ClockView.mainFont)
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(ClockView.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if clock.isCountup {
                let time = ClockTime.getPaddedPresentation(for: clock.time.timeInSeconds)
                Text("\(time)")
                    .offset(x: -10, y: 10)
                    .foregroundColor(.secondary)
                    .font(LayoutUtils.timeFont)
            }
        }
    }
}

struct ClockNumber: View {
    var number: Int = 0
    
    var body: some View {
        Text("\(number)")
            .frame(width: 50, height: 80)
            .background(.lightOrange)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack {
                ClockView.simpleCountup
                    .frame(width: 320)
                ClockView.simpleCountdown
                    .frame(width: 320)
            }
        }
    }
}
