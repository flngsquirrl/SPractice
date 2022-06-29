//
//  Array-Wrapper.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.06.22.
//

import Foundation

extension Array {
    
    static func wrapElement<Element>(element: Element) -> [Element] {
        var array = Array<Element>()
        array.append(element)
        return array
    }
    
}
