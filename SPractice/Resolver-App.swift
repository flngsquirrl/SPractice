//
//  Resolver.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.10.22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        register { SettingsManager() }
            .implements(RestSettingsProvider.self)
            .implements(TabataSettingsProvider.self)

        register { BasicAudioPlayer() }
            .implements(AudioPlayer.self)
    }
}
