//
//  TemplateValidator.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

protocol TemplateValidator {

    associatedtype Template

    func isValid(_ template: Template) -> Bool

    func isNameValid(of template: Template) -> Bool

    func isValidToPractice(_ template: Template) -> Bool
}
