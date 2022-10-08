//
//  ProgramServiceTests.swift
//  SPracticeTests
//
//  Created by Yuliya Charniak on 8.10.22.
//

import Resolver
import XCTest

@testable import SPractice

final class ProgramServiceTests: XCTestCase {

    var sut: ProgramService!

    override func setUpWithError() throws {
        try super.setUpWithError()

        Resolver.registerMockServices()
        sut = ProgramService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testProgramTemplateWithFlowDurationUnlimited() {
        let duration = sut.calculateDuration(for: ModelAssets.programTemplateWithFlow)
        XCTAssertTrue(duration == .unlimited)
    }
}

enum ModelAssets {

    static let exerciseTemplateFlow = ExerciseTemplate(type: .flow, name: "exerciseTemplateFlow")
    static let programTemplateWithFlow = ProgramTemplate(name: "programTemplateWithFlow", exercises: [exerciseTemplateFlow])

}
