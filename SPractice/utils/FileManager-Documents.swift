//
//  FileManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.06.22.
//

import Foundation

extension FileManager {

    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
