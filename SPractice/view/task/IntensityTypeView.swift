//
//  IntensityTypeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.07.22.
//

import SwiftUI

struct IntensityTypeView: View {
    
    var intensity: IntensityType?
    
    var body: some View {
        HStack {
            if let intensity = intensity {
                IntensityTypeImage(type: intensity)
                Text("\(intensity.rawValue)")
            } else {
                Image(systemName: "questionmark")
                Text("unknown")
            }
        }
    }
}

struct IntensityTypeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            IntensityTypeView(intensity: .rest)
            IntensityTypeView(intensity: .activity)
            IntensityTypeView(intensity: nil)
        }
    }
}
