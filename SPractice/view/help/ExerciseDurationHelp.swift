//
//  ExerciseDurationHelp.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct ExerciseDurationHelp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Duration").term() +
                Text(" is how much time the exercise lasts during practice.")
            }
            .padding([.bottom])

            Grid(alignment: .top) {
                GridRow(alignment: .firstTextBaseline) {
                    ExerciseDurationView(for: ExerciseTemplate.vasihsthasana).accented()
                        .frame(width: 60)
                    Text("defined: you set it for a timer exercise;\nfor a tabata exercises it is calculated based on Settings")
                        .gridColumnAlignment(.leading)
                }

                Divider()

                GridRow(alignment: .firstTextBaseline) {
                    LayoutUtils.unlimitedDurationImage
                        .accented()
                    HStack {
                        Text("unlimited: you don't limit time for flow exercises")
                        Spacer()
                    }

                }
            }
        }
    }
}

struct ExerciseDurationHelp_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDurationHelp()
    }
}
