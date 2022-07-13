//
//  RestartIconButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.07.22.
//

import SwiftUI

struct RestartIconButton: View {
    
    var onClick: () -> Void
    
    var body: some View {
        Button() {
            onClick()
        } label: {
            Image(systemName: "arrow.clockwise")
        }
    }
}

struct RestartIconButton_Previews: PreviewProvider {
    static var previews: some View {
        RestartIconButton(onClick: {})
    }
}
