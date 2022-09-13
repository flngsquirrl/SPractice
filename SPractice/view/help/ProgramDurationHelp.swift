//
//  ProgramDurationHelpContent.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct ProgramDurationHelp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Program duration").term()
                + Text(" shows how much time it takes to practice the program.")
            }
            .padding([.bottom])

            Grid(alignment: .top) {
                GridRow {
                    LayoutUtils.unknownDurationText.term()
                    Text("not defined: there are no exercises in the program, or their durations are not set")
                }

                Divider()

                GridRow {
                    LayoutUtils.approximationMark.accented()

                    VStack(alignment: .leading) {
                        Text("flexible: the program contains flow exercises")
                            .padding([.bottom])

                        VStack(alignment: .leading) {
                            Text("can preceed the sum of known exercises durations, like")
                                .padding([.bottom], 5)
                            ProgramDurationView(for: ProgramTemplate.simpleYoga, mode: .extended)
                        }
                    }
                    .gridColumnAlignment(.leading)
                }
            }
        }
    }
}

struct ProgramDurationHelpContent_Previews: PreviewProvider {
    static var previews: some View {
        ProgramDurationHelp()
            .wrapped()
    }
}
