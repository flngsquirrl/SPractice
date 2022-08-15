//
//  SquirrelIcon.swift
//  SPractice
//
//  Created by Yuliya Charniak on 15.08.22.
//

import SwiftUI

struct SquirrelIcon: View {
    var body: some View {
        let strokeStyle = StrokeStyle(lineWidth: 1.3, lineCap: .round, lineJoin: .round)
        
        Squirrel()
            .stroke(.secondary, style: strokeStyle)
            .frame(width: 22, height: 22)
    }
}

struct SquirrelIcon_Previews: PreviewProvider {
    static var previews: some View {
        SquirrelIcon()
    }
}
