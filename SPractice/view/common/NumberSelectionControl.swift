//
//  NumberSelectionControl.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import SwiftUI

struct NumberSelectionControl: View {

    @Binding var number: Int

    var range: [Int] = Array(stride(from: 1, through: 10, by: 1))

    var body: some View {
        HStack(spacing: 0) {
            Picker("Number selection", selection: $number) {
                ForEach(range, id: \.self) {
                    Text("\($0)")
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
        }
    }

    static var secondsUnit: String {
        MeasurementFormatter().string(from: UnitDuration.seconds)
    }
}

struct NumberSelectionControl_Previews: PreviewProvider {
    static var previews: some View {
        NumberSelectionControl(number: .constant(3))
    }
}
