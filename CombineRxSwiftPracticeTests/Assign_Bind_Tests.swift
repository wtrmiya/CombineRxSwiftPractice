//
//  Assign_Bind_Tests.swift
//  CombineRxSwiftPracticeTests
//
//  Created by Wataru Miyakoshi on 2023/02/15.
//

import XCTest
import Combine

final class Assign_Bind_Tests: XCTestCase {

    // MARK: - Combine
    func testAssign() {
        
        class SomeObject {
            static let expectedValue = "Hello"
            let expectation = XCTestExpectation(description: #function)
            
            var value: String = "" {
                didSet {
                    XCTAssertEqual(value, Self.expectedValue)
                    expectation.fulfill()
                }
            }
        }
        
        let object = SomeObject()
        let examplePublisher = Just(SomeObject.expectedValue)
        
        let cancellable = examplePublisher
            .assign(to: \.value, on: object)
        
        wait(for: [object.expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
    }
}
