//
//  LayoutUtils.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import Foundation
import SwiftUI

enum LayoutUtils {

    static let unknownDurationText = Text("?")
    static let unlimitedDurationImage = Image(systemName: "infinity")
    static let approximationMark = Image(systemName: ExerciseTypeImage.imageName(for: .flow))

    static func getPreferredLogoSize(parentContainerSize: CGSize) -> CGFloat {
        min(min(parentContainerSize.width, parentContainerSize.height) * 0.5, 160)
    }

    static func centralFrameWidth(parentContainerSize: CGSize) -> CGFloat {
        min(parentContainerSize.width * 0.8, 500)
    }

    static func getLogo(of color: Color = .mainColor, parentContainerSize: CGSize) -> some View {
        let size = LayoutUtils.getPreferredLogoSize(parentContainerSize: parentContainerSize)
        return SquirrelInWheelLogo(lineWidth: 7, color: color)
            .frame(width: size, height: size)

    }
}
