//
//  PracticeSequenceView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.05.22.
//

import SwiftUI

struct PracticeSequenceView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Previous:")
                Text("Next:")
            }
            
            Spacer()
        }
        .padding(15)
        .background(.lightForeground)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct PracticeSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightBright
                .ignoresSafeArea()
            PracticeSequenceView()
                .frame(width: 320)
        }
    }
}
