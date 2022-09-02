//
//  DurationSecondsControl.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct DurationSecondsControl: View {

    @Binding var seconds: Int

    var range: [Int] = Array(stride(from: 0, through: 60, by: 10))
    var format = "%02d"

    var body: some View {
        HStack(spacing: 0) {
            Picker("Duration seconds", selection: $seconds) {
                ForEach(range, id: \.self) {
                    Text(String(format: format, $0))
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)

            Text("\(Self.secondsUnit)")
                .foregroundColor(.secondary)
        }
    }

    static var secondsUnit: String {
        MeasurementFormatter().string(from: UnitDuration.seconds)
    }
}

struct DurationSecondsControl_Previews: PreviewProvider {
    static var previews: some View {
        DurationSecondsControl(seconds: .constant(4))
    }
}
