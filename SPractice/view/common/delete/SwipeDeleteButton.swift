//
//  SwipeDeleteButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.09.22.
//

import SwiftUI

struct SwipeDeleteButton: View {

    var onDelete: () -> Void

    var body: some View {
        Button {
            onDelete()
        } label: {
            Label("Delete", systemImage: "trash")
        }
        .tint(.destructiveColor)
    }
}

struct SwipeDeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeDeleteButton {}
    }
}
