//
//  IntensityView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.07.22.
//

import SwiftUI

struct IntensityView: IconTextView {
    
    var intensity: Intensity?
    var mode: IconTextMode = .icon
    
    var icon: some View {
        IntensityImage(intensity: intensity)
    }
    
    var text: some View {
        if let intensity = intensity {
            Text("\(intensity.rawValue)")
        } else {
            Text("unknown")
        }
    }
}

struct IntensityView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            IntensityView(intensity: .rest)
            IntensityView(intensity: .rest, mode: .iconAndText)
            IntensityView(intensity: .activity)
            IntensityView(intensity: .activity, mode: .iconAndText)
            IntensityView(intensity: nil)
            IntensityView(intensity: nil, mode: .iconAndText)
        }
    }
}
