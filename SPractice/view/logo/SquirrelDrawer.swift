//
//  SquirrelDrawer.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import Foundation
import SwiftUI

struct SquirrelDrawer {
    
    static func full(in rect: CGRect) -> Path {
        var path = Path()

        path.addPath(rightWing(in: rect))
        path.addPath(leftWing(in: rect))
        path.addPath(spine(in: rect))
        
        return path
    }
    
    static func rightWing(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.25))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.825, y: rect.height * 0.125), control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.25))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.825, y: rect.height * 0.875), control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.75), control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75))
        
        return path
    }
    
    static func leftWing(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.75))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.17, y: rect.height * 0.875), control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.75))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.17, y: rect.height * 0.125), control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.25), control: CGPoint(x: rect.width * 0.25, y: rect.width * 0.25))
        
        return path
    }
    
    static func spine(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.15))
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 1.07))
        
        return path
    }
}
