//
//  FileManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.06.22.
//

import Foundation

extension FileManager {

    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }

}
