//
//  tapAlphaUITests.swift
//  tapAlphaUITests
//
//  Created by 강동영 on 3/13/24.
//

import XCTest

class TestView: XCTestCase, UITapAvailable {
    typealias TapAvailables = TapAvailable
    
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
        super.init()
    }
    
    enum TapAvailable {
        case isHiddenButton
    }
    
    func tap(_ tap: TapAvailable) {
        switch tap {
        case .isHiddenButton:
            app.buttons["TestIsHiddenButton"].tap()
        }
    }
}
final class tapAlphaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        
        app.launch()
        let stackView = app.otherElements["TestStackView"]
        let view = app.otherElements["TestView1"]
        let alphaView = app.otherElements["TestAlphaView"]
        let hiddenTestButton = app.buttons["TestIsHiddenButton"]
        
        let originheight = stackView.frame.height
        let childHeights = view.frame.height + alphaView.frame.height
        print(">> stackView originheight: \(originheight)")
        print(">> stackView child's height: \(childHeights)")
        
        XCTAssertTrue(originheight == childHeights)
        hiddenTestButton.tap()
        let shrinkHeight = stackView.frame.height
        print(">> stackView originheight: \(originheight)")
        print(">> stackView shrinkHeight: \(shrinkHeight)")
        print(">> stackView child's height: \(childHeights)")
        print(">> stackView view.frame.height: \(view.frame.height)")
        print(">> stackView alphaView.frame.height: \(alphaView.frame.height)")
        
        XCTAssertTrue(shrinkHeight == originheight - alphaView.frame.height)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

protocol UITapAvailable {
    associatedtype TapAvailables
    
    func tap(_ tap: TapAvailables)
}
