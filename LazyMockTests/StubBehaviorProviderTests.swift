//
//  StubBehaviorProviderTests.swift
//  LazyMockTests
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import XCTest
@testable import LazyMock

class StubBehaviorProviderTests : XCTestCase {
    
    private var sut: StubBehaviorProvider!
    
    override
    func setUp() {
        super.setUp()
        
        sut = .init()
    }
    
    func test_prepare_default() {
        // Given
        let response = 42
        
        // When
        sut.prepare(response: .value(response), numberOfTimes: 0)
        
        // Then
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, response)
        
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, response)
        
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, response)
    }
    
    func test_prepare_defaultClosure() {
        // Given
        enum LocalTestError : Error { case expected }
        let block: ([Any]) -> StubbedResponse = { (args) in
            let input = args[0] as! Int
            guard input >= 0 else { return .error(LocalTestError.expected) }
            return .value(input + 1)
        }
        
        // When
        sut.prepare(response: .matcher(block), numberOfTimes: 0)
        
        // Then
        XCTAssertTrue(sut.canStub)
        XCTAssertTrue(sut.stub().isMatcher)
        XCTAssertEqual(sut.stub().matchArgument([0])?.value as? Int, 1)
        XCTAssertEqual(sut.stub().matchArgument([1])?.value as? Int, 2)
        XCTAssertEqual(sut.stub().matchArgument([-1])?.error as? LocalTestError, .expected)
    }
    
    func test_prepare_sequential() {
        // Given
        let r1 = 42
        let r2 = 31
        
        // When
        sut.prepare(response: .value(r1), numberOfTimes: 2)
        sut.prepare(response: .value(r2), numberOfTimes: 1)
        
        // Then
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, r1)
        
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, r1)
        
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, r2)
        
        XCTAssertFalse(sut.canStub)
    }
    
    func test_prepare_defaultAndSequential() {
        // Given
        let def = 42
        let r1 = 31
        
        // When
        sut.prepare(response: .value(def), numberOfTimes: 0)
        sut.prepare(response: .value(r1), numberOfTimes: 1)
        
        // Then
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, r1)
        
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, def)
        
        XCTAssertTrue(sut.canStub)
        XCTAssertEqual(sut.stub().value as? Int, def)
        
        XCTAssertTrue(sut.canStub)
    }
    
    func test_reset() {
        // Given
        let def = 42
        
        // When
        sut.prepare(response: .value(def), numberOfTimes: 0)
        sut.reset()
        
        // Then
        XCTAssertFalse(sut.canStub)
    }
    
}
