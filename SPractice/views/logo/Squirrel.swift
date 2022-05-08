//
//  WingShape.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import SwiftUI

struct Squirrel: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addPath(SquirrelDrawer.full(in: rect))
        return path
    }
}
