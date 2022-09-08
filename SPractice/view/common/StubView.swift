//
//  StabView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import SwiftUI

struct StabView: View {
    var body: some View {
        ZStack {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
            Text("Please, select an item from the left-hand menu.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

struct StabView_Previews: PreviewProvider {
    static var previews: some View {
        StabView()
    }
}
