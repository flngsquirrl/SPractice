//
//  SquirrelInWheel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import Foundation
import SwiftUI

struct SquirrelInWheel: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5), radius: rect.width * 0.5, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        path.addPath(SquirrelDrawer.full(in: rect))
        return path
    }
}
