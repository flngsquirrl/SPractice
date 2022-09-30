//
//  String-Empty.swift
//  SPractice
//
//  Created by Yuliya Charniak on 15.07.22.
//

import Foundation

extension String {

    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isEmptyString: Bool {
        self.trim().isEmpty
    }
}
