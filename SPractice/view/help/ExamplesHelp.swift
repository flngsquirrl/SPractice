//
//  ExamplesHelp.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct ExamplesHelp: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Group {
                    Text("Examples").term()
                    + Text(" are demo templates.")
                }
                .padding([.bottom])

                Text("They can be modified or deleted and later restored from Settings.")
            }
            Spacer()
        }
    }
}

struct ExamplesHelp_Previews: PreviewProvider {
    static var previews: some View {
        ExamplesHelp()
    }
}
