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
                Text("Practice sequence goes here")
            }
            
            Spacer()
        }
        .padding(15)
        .background(.creamy)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PracticeSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightNavy
                .ignoresSafeArea()
            PracticeSequenceView()
                .frame(width: 320)
        }
    }
}
