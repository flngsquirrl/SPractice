//
//  IntensityView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.07.22.
//

import SwiftUI

struct IntensityView: View {
    
    var intensity: Intensity?
    
    var body: some View {
        HStack {
            if let intensity = intensity {
                IntensityImage(type: intensity)
                Text("\(intensity.rawValue)")
            } else {
                Image(systemName: "questionmark")
                Text("unknown")
            }
        }
    }
}

struct IntensityView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            IntensityView(intensity: .rest)
            IntensityView(intensity: .activity)
            IntensityView(intensity: nil)
        }
    }
}
