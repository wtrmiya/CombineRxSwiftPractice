//
//  CombineRxSwiftPracticeTests.swift
//  CombineRxSwiftPracticeTests
//
//  Created by Wataru Miyakoshi on 2023/02/14.
//

import XCTest
import Combine

final class Sink_Subscribe_Tests: XCTestCase {

    // MARK: - Combine
    func testSink() {
        let expectation = XCTestExpectation()
        let expectedResult = 5
        let examplePublisher = Just(expectedResult)
        
        let cancellable = examplePublisher
            .sink { value in
                print(".sink() received \(String(describing: value))")
                XCTAssertEqual(value, expectedResult)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
    }

}
