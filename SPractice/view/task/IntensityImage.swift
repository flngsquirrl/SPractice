//
//  IntensityImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import SwiftUI

struct IntensityImage: View {
    var intensity: Intensity?
    var isFilled = false

    var body: some View {
        Image(systemName: Self.imageName(for: intensity, isFilled: isFilled))
    }
    
    static func imageName(for intensity: Intensity?, isFilled: Bool = false) -> String {
        let postfix = isFilled ? ".fill" : ""
        
        if let intensity = intensity {
            switch intensity {
            case .activity:
                return "sun.max.circle\(postfix)"
            case .rest:
                return "moon.circle\(postfix)"
            case .mixed:
                return "circle.lefthalf.filled"
            }
        } else {
            return "questionmark.circle\(postfix)"
        }
        
    }
}

struct IntensityImage_Previews: PreviewProvider {
    static var previews: some View {
        List {
            IntensityImage(intensity: .activity)
            IntensityImage(intensity: .rest)
            IntensityImage(intensity: .mixed)
            
            IntensityImage(intensity: .activity, isFilled: true)
            IntensityImage(intensity: .rest, isFilled: true)
            IntensityImage(intensity: .mixed, isFilled: true)
        }
    }
}
