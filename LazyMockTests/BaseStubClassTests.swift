//
//  BaseStubClassTests.swift
//  LazyMockTests
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import XCTest
import LazyMock

// TODO: Move to example app target
class BaseStubClassTests : XCTestCase {
    
    private var sut: StubRepository!
    private var caller: SomeClass!
    
    override
    func setUp() {
        super.setUp()
        
        sut = .init()
        caller = .init(repository: sut)
    }
    
    func test_whenReturn() {
        // Given
        let idList = ["foo", "bar",]
        
        sut.when(
            "getAllUserIDList()",
            isCalledReturn: idList,
            numberOfTimes: 0)
        
        // When
        XCTAssertNoThrow(try caller.doSomething())
        
        // Then
        XCTAssertEqual(caller.allUserIDList, idList)
    }
    
    func test_whenThrow() {
        // Given
        enum SomeError : Error { case test }
        let error: SomeError = .test
        
        sut.when(
            "getAllUserIDList()",
            isCalledThrow: error,
            numberOfTimes: 0)
        
        // When
        XCTAssertThrowsError(try caller.doSomething()) {
            XCTAssertEqual($0 as? SomeError, error)
        }
        
        // Then
        XCTAssert(caller.allUserIDList.isEmpty)
    }
    
    func test_throwsStubNotFound() {
        // Given
        let idList = ["foo",]
        sut.when(
            "getAllUserIDList()",
            isCalledReturn: idList,
            numberOfTimes: 1)
        
        // When
        XCTAssertNoThrow(try caller.doSomething())
        XCTAssertEqual(caller.allUserIDList, idList)
        caller = .init(repository: sut)
        
        XCTAssertThrowsError(try caller.doSomething()) {
            XCTAssertEqual($0 as? StubError, .stubNotFound)
        }
        // Then
        XCTAssert(caller.allUserIDList.isEmpty)
    }
    
    func test_throwsInvalidStub() {
        // Given
        let invalidResponse = 0
        
        sut.when(
            "getAllUserIDList()",
            isCalledReturn: invalidResponse,
            numberOfTimes: 0)
        
        // When
        XCTAssertThrowsError(try caller.doSomething()) {
            XCTAssertEqual($0 as? StubError, .invalidStubResponse)
        }
        // Then
        XCTAssert(caller.allUserIDList.isEmpty)
    }
    
    func test_reset() {
        // Given
        test_whenReturn()
        sut.resetStubBehavior()
        
        // When
        // Then
        XCTAssertThrowsError(try caller.doSomething()) {
            XCTAssertEqual($0 as? StubError, .stubNotFound)
        }
    }
    
}

private class SomeClass {
    
    // MARK: Interface
    
    private(set) var allUserIDList: [String] = []
    
    /**
     Fetches the full list of user IDs.
     */
    func doSomething() throws {
        allUserIDList = try repository.getAllUserIDList()
    }
    
    /**
     Creates a new user ID and refreshes `allUserIDList`.
     */
    func doSomethingElse() throws {
        try repository.createUser(id: UUID().uuidString)
        try doSomething()
    }
    
    // MARK: Private
    
    private let repository: SomeRepository
    
    // MARK: Init
    
    init(repository: SomeRepository) {
        self.repository = repository
    }
    
}

private protocol SomeRepository : class {
    
    func getAllUserIDList() throws -> [String]
    
    func createUser(id: String) throws
    
}

private class StubRepository : BaseStubClass, SomeRepository {
    
    func getAllUserIDList() throws -> [String] {
        return try stub(#function)
    }
    
    func createUser(id: String) throws {
        // TODO: stub differently based on the input arg
        return try stub(#function)
    }
    
}
