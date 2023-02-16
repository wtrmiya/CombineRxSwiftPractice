//
//  Throttle_Throttle_Tests.swift
//  CombineRxSwiftPracticeTests
//
//  Created by Wataru Miyakoshi on 2023/02/17.
//

import XCTest
import Combine

final class Throttle_Throttle_Tests: XCTestCase {

    // MARK: - Combine
    func testCombineThrottleLatestFalse() {
        
        // エラーを返却しないPassthroughSubjectを用いてみる。
        let subject = PassthroughSubject<Int, Never>()
        
        // 値を受け取る側
        let cancellable = subject
            .sink { value in
                print(".sink() receive: ", value)
            }
        
        // 値を送信する
        subject.send(5)
        subject.send(10)
        subject.send(20)
        
        XCTAssertNotNil(cancellable)
    }
}
