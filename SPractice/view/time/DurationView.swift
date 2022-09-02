//
//  DurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import SwiftUI

struct DurationView: View {
    enum Mode {
        case padded
        case extended
    }

    let duration: Int
    let mode: Mode

    var body: some View {
        if mode == .padded {
            Text(paddedDuration)
                .font(LayoutUtils.timeFont)
        } else {
            Text(extendedDuration)
        }
    }

    var paddedDuration: String {
        ClockTime.getPaddedPresentation(for: duration)
    }

    var extendedDuration: String {
        ClockTime.getExtendedPresentation(for: duration)
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DurationView(duration: 130, mode: .padded)
            DurationView(duration: 130, mode: .extended)

            DurationView(duration: 60 * 60 * 2 + 130, mode: .padded)
            DurationView(duration: 60 * 60 * 2 + 130, mode: .extended)
        }
    }
}
