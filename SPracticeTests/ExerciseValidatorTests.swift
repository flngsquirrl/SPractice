//
//  SPracticeTests.swift
//  ExerciseValidatorTests
//
//  Created by Yuliya Charniak on 2.10.22.
//

import XCTest

@testable import SPractice

final class ExerciseValidatorTests: XCTestCase {

    var sut: ExerciseValidator!

    var basicValidTemplate = ExerciseTemplate(name: "test name")

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ExerciseValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testTemplateWithNameSetIsValid() {
        let template = basicValidTemplate

        let isValid = sut.isValid(template)

        XCTAssertTrue(isValid, "Template with name should be valid")
    }

    func testTemplateWithNameNotSetIsNotValid() {
        var template = ExerciseTemplate()
        template.name = ""

        let isValid = sut.isValid(template)

        XCTAssertFalse(isValid, "Template without name should not be valid")
    }

    func testTemplateWithTypeNotSetIsNotValidToPractice() {
        let template = basicValidTemplate

        let isValid = sut.isValidToPractice(template)

        XCTAssertFalse(isValid, "Template without type should not be valid to practice")
    }

    func testFlowIsValidToPractice() {
        var template = basicValidTemplate
        template.type = .flow

        let isValid = sut.isValidToPractice(template)

        XCTAssertTrue(isValid, "Flow template should be valid to practice")
    }

    func testTimerWithDurationKnownIsValidToPractice() {
        var template = basicValidTemplate
        template.type = .timer
        template.duration = .known(30)

        let isValid = sut.isValidToPractice(template)

        XCTAssertTrue(isValid, "Timer template with known duration should be valid to practice")
    }

    func testTimerWithZeroDurationIsNotValidToPractice() {
        var template = basicValidTemplate
        template.type = .timer
        template.duration = .known(0)

        let isValid = sut.isValidToPractice(template)

        XCTAssertFalse(isValid, "Timer template with 0 duration should not be valid to practice")
    }

    func testTabataIsValidToPractice() {
        var template = basicValidTemplate
        template.type = .tabata

        let isValid = sut.isValidToPractice(template)

        XCTAssertTrue(isValid, "Tabata template should be valid to practice")
    }
}
