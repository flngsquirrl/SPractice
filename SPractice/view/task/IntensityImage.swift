//
//  IntensityImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import SwiftUI

struct IntensityImage: View {
    var type: Intensity
    var isFilled = false

    var body: some View {
        Image(systemName: Self.imageName(for: type, isFilled: isFilled))
    }
    
    static func imageName(for type: Intensity, isFilled: Bool = false) -> String {
        let postfix = isFilled ? ".fill" : ""
        
        switch type {
        case .activity:
            return "sun.max.circle\(postfix)"
        case .rest:
            return "moon.circle\(postfix)"
        case .mixed:
            return "circle.lefthalf.filled"
        }
        
    }
}

struct IntensityImage_Previews: PreviewProvider {
    static var previews: some View {
        List {
            IntensityImage(type: .activity)
            IntensityImage(type: .rest)
            
            IntensityImage(type: .activity, isFilled: true)
            IntensityImage(type: .rest, isFilled: true)
        }
    }
}
