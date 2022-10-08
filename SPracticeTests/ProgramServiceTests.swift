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
    @LazyInjected var tabataSettings: TabataSettingsProvider

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

    func testProgramTemplateWithTimerDurationCorrect() {
        let duration = sut.calculateDuration(for: ModelAssets.programTemplateWithTimerDurationSet)

        let expectedDuration = ModelAssets.programTemplateWithTimerDurationSet.exercises[0].duration
        XCTAssertTrue(duration == expectedDuration)
    }

    func testProgramTemplateWithTabataDurationCorrect() {
        let duration = sut.calculateDuration(for: ModelAssets.programTemplateWithTabata)

        let expectedDuration = Duration.known(tabataSettings.exerciseDuration)
        XCTAssertTrue(duration == expectedDuration)
    }
}

enum ModelAssets {

    static let exerciseTemplateFlow = ExerciseTemplate(type: .flow, name: "exerciseTemplateFlow")
    static let programTemplateWithFlow = ProgramTemplate(name: "programTemplateWithFlow", exercises: [exerciseTemplateFlow])

    static let exerciseTemplateTimerDurationSet = ExerciseTemplate(type: .timer, name: "exerciseTemplateTimer", duration: .known(30))
    static let programTemplateWithTimerDurationSet = ProgramTemplate(
        name: "programTemplateWithTimerDurationSet",
        exercises: [exerciseTemplateTimerDurationSet])

    static let exerciseTemplateTabata = ExerciseTemplate(type: .tabata, name: "exerciseTemplateTabata", duration: .unknown)
    static let programTemplateWithTabata = ProgramTemplate(
        name: "programTemplateWithTabata",
        exercises: [exerciseTemplateTabata])

}
