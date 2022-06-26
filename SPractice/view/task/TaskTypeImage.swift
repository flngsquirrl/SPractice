//
//  IntensityTypeImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import SwiftUI

struct IntensityTypeImage: View {
    var type: IntensityType
    var isFilled = false

    var body: some View {
        Image(systemName: Self.imageName(for: type, isFilled: isFilled))
    }
    
    static func imageName(for type: IntensityType, isFilled: Bool = false) -> String {
        let postfix = isFilled ? ".fill" : ""
        
        switch type {
        case .activity:
            return "sun.max.circle\(postfix)"
        case .rest:
            return "moon.circle\(postfix)"
        }
        
    }
}

struct IntensityTypeImage_Previews: PreviewProvider {
    static var previews: some View {
        List {
            IntensityTypeImage(type: .activity)
            IntensityTypeImage(type: .rest)
            
            IntensityTypeImage(type: .activity, isFilled: true)
            IntensityTypeImage(type: .rest, isFilled: true)
        }
    }
}
