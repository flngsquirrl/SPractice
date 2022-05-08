//
//  RightWing.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import Foundation
import SwiftUI

struct RightWing: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addPath(SquirrelDrawer.rightWing(in: rect))
        return path
    }
}
