//
//  DurationControl.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct DurationControl: View {
    
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var onMinutesChange: ((Int) -> Void)? = nil
    var onSecondsChange: ((Int) -> Void)? = nil
    
    static let secondsRange = Array(stride(from: 0, to: 60, by: 10))
    
    var body: some View {
        DurationMinutesControl(minutes: $minutes)
            .onChange(of: minutes) {
                onMinutesChange(newValue: $0)
                onMinutesChange?($0)
            }
        
        DurationSecondsControl(seconds: $seconds, range: Self.secondsRange)
            .onChange(of: seconds) { onSecondsChange?($0)}
            .disabled(areSecondsDisabled)
    }
    
    func onMinutesChange(newValue: Int) {
        if newValue == 60 {
            seconds = 0
        }
    }
    
    var areSecondsDisabled: Bool {
        minutes == 60
    }
}

struct DurationControl_Previews: PreviewProvider {
    static var previews: some View {
        DurationControl(minutes: .constant(2), seconds: .constant(30), onMinutesChange: { _ in }, onSecondsChange: { _ in })
    }
}
