//
//  ExamplesInfo.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct ExamplesInfo: View {
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

struct ExamplesInfo_Previews: PreviewProvider {
    static var previews: some View {
        ExamplesInfo()
    }
}
