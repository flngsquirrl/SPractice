//
//  TemplateManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import Foundation

protocol TemplateManager {
    
    associatedtype T
    
    var templates: [T] {get set}
    
    func addNewTemplate(template: T)
    
    func removeItems(at offsets: IndexSet)
    
    func moveItems(from fromOffsets: IndexSet, to toOffsets: Int)
    
}

extension TemplateManager {
    
    mutating func addNewTemplate(template: T) {
        templates.append(template)
    }
    
    mutating func removeItems(at offsets: IndexSet) {
        templates.remove(atOffsets: offsets)
    }
    
    mutating func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        templates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
}
