//
//  MainFeedCoordinatorTests.swift
//  NavigationTests
//
//  Created by Андрей Васильев on 02.02.2023.
//

import XCTest

final class MainFeedCoordinatorTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testCheckTheCurrentOpenController() throws {

        let app = XCUIApplication()
        app.launch()

        app.buttons["Перейти на пост"].tap()
        XCTAssert(app.buttons["Удалить пост"].exists)
    }

}
