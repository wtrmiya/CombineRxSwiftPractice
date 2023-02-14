//
//  Assign_Bind_Tests.swift
//  CombineRxSwiftPracticeTests
//
//  Created by Wataru Miyakoshi on 2023/02/15.
//

import XCTest
import Combine
import RxSwift
import RxCocoa

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
    
    // MARK: - RxSwift
    func testBind() {
        let expectation = XCTestExpectation(description: #function)
        let expectedValue = "Hello"
        
        let bag = DisposeBag()
        let subject = PublishSubject<String>()
        
        // テスト結果の観測のためにsubscribeを使用する。
        subject
            .subscribe(onNext: { value in
                XCTAssertEqual(value, expectedValue)
                expectation.fulfill()
            })
            .disposed(by: bag)
        
        let observable = Observable<String>.just(expectedValue)
        
        observable
            .bind(to: subject)
            .disposed(by: bag)
        
        wait(for: [expectation], timeout: 5)
    }
}
