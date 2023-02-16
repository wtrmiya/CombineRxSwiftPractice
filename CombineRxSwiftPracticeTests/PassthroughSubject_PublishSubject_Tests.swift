//
//  PassthroughSubject_PublishSubject_Tests.swift
//  CombineRxSwiftPracticeTests
//
//  Created by Wataru Miyakoshi on 2023/02/17.
//

import XCTest
import Combine
import RxSwift
import RxCocoa

final class PassthroughSubject_PublishSubject_Tests: XCTestCase {

    // MARK: - Combine
    func testPassthroughSubject() {
        let expectation = XCTestExpectation()
        let expectedValues = [5, 10, 20]
        
        // エラーを返却しないPassthroughSubjectを用いてみる。
        let subject = PassthroughSubject<Int, Never>()
        
        var result = [Int]()
        var count = 0
        
        // 値を受け取る側
        let cancellable = subject
            .sink { value in
                print(".sink() receive: ", value)
                result.append(value)
                count += 1
                
                if count == expectedValues.count {
                    print("fullfill()")
                    expectation.fulfill()
                }
            }
        
        for value in expectedValues {
            subject.send(value)
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expectedValues)
        XCTAssertNotNil(cancellable)
    }
    
    
    // MARK: - RxSwift
    func testPublishSubject() {
        let expectation = XCTestExpectation()
        let expectedValues = [5, 10, 20]
        
        let subject = PublishSubject<Int>()
        let bag = DisposeBag()
        
        var result = [Int]()
        var count = 0
        
        // 値を受け取る側
        subject
            .subscribe(onNext: { value in
                print(".subscribe() receive: ", value)
                result.append(value)
                count += 1
                
                if count == expectedValues.count {
                    print("fullfill()")
                    expectation.fulfill()
                }
            })
            .disposed(by: bag)
        
        
        for value in expectedValues {
            subject.onNext(value)
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expectedValues)
    }
}


