//
//  TabataSettingsProvider.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.10.22.
//

import Foundation

protocol TabataSettingsProvider {

    var tabataWarmUpDuration: Int {get}
    var tabataActivityDuration: Int {get}
    var tabataRestDuration: Int {get}
    var tabataCoolDownDuration: Int {get}
    var tabataCycles: Int {get}

    var tabataExerciseDuration: Int {get}

}
