//
//  ExampleMark.swift
//  SPractice
//
//  Created by Yuliya Charniak on 15.08.22.
//

import SwiftUI

struct ExampleMark: View {
    var body: some View {
        Image(systemName: "bookmark.fill")
            .scaleEffect(1.5)
            .foregroundColor(.mainColor.opacity(0.6))
            .offset(x: 0, y: -10)
    }
}

struct ExampleMark_Previews: PreviewProvider {
    static var previews: some View {
        ExampleMark()
    }
}
