//
//  ExerciseIntensityHelp.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct ExerciseIntensityHelp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Intensity ").term() +
                Text("is a level of physical effort you apply during the exercise.")
            }
            .padding([.bottom])

            Text("There are 3 types of intensity:")
                .padding([.bottom])

            Grid(alignment: .top) {
                GridRow {
                    IntensityView(intensity: .activity, mode: .iconAndText)
                        .accented()
                        .gridColumnAlignment(.leading)
                }

                Divider()

                GridRow {
                    IntensityView(intensity: .rest, mode: .iconAndText)
                        .accented()
                }

                Divider()

                GridRow {
                    IntensityView(intensity: .mixed, mode: .iconAndText)
                        .accented()
                }
            }
        }
    }
}

struct ExerciseIntensityHelp_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseIntensityHelp()
    }
}
