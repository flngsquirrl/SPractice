//
//  DurationMinutesControl.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct DurationMinutesControl: View {

    @Binding var minutes: Int

    var range = 0..<61
    var format = "%02d"

    var body: some View {
        HStack(spacing: 0) {
            Picker("Duration minutes", selection: $minutes) {
                ForEach(range, id: \.self) {
                    Text(String(format: format, $0))
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)

            Text("\(Self.minutesUnit)")
                .foregroundColor(.secondary)
        }
    }

    static var minutesUnit: String {
        MeasurementFormatter().string(from: UnitDuration.minutes)
    }
}

struct DurationMinutesControl_Previews: PreviewProvider {
    static var previews: some View {
        DurationMinutesControl(minutes: .constant(6))
    }
}
