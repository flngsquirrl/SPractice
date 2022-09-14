//
//  ExerciseTypeInfo.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct ExerciseTypeInfo: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Type ").term() +
                Text("defines how you exercise.")
            }
            .padding([.bottom])

            Text("There are 3 options.")
                .padding([.bottom])

            Grid(alignment: .top) {
                GridRow {
                    ExerciseTypeView(type: .flow)
                        .accented()
                    Group {
                        Text("flow").term()
                        + Text(": you decide when you finish and notify the app by pressing a button")
                    }
                    .gridColumnAlignment(.leading)
                }

                Divider()

                GridRow {
                    ExerciseTypeView(type: .timer)
                        .accented()
                    Text("timer").term() +
                    Text(": you set the time and practice with the count down")
                }

                Divider()

                GridRow {
                    ExerciseTypeView(type: .tabata)
                        .accented()
                    Text("tabata").term() +
                    Text(": you follow Tabata HIIT technique, repeating intervals of activity and rest")
                }
            }
        }
    }
}

struct ExerciseTypeInfo_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTypeInfo()
    }
}
