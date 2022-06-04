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
        Group {
            if clock.isCountup {
                ZStack {
                    Image(systemName: ClockView.countupImageName)
                        .font(mainFont)
                        .foregroundColor(.lightOrange)
                        .scaleEffect(2)
                 }
            } else {
                HStack(spacing: 4) {
                    ClockNumber(number: clock.minutesFirstDigit)
                    ClockNumber(number: clock.minutesSecondDigit)
                    Text(":")
                        .foregroundColor(.lightOrange)
                        .font(mainFont)
                        .padding(8)
                    ClockNumber(number: clock.secondsFirstDigit)
                    ClockNumber(number: clock.secondsSecondDigit)
                }
                .padding(20)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(.creamy)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    struct ClockNumber: View {
        var number: Int = 0
        
        var body: some View {
            Text("\(number)")
                .frame(width: 50, height: 80)
                .background(.lightOrange)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.creamy)
            
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightNavy
                .ignoresSafeArea()
            VStack {
                ClockView.simpleCountup
                    .frame(width: 320, height: 300)
                ClockView.simpleCountdown
                    .frame(width: 320, height: 300)
            }
        }
    }
}
