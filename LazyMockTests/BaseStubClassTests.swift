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
    
    private var someRepository: StubRepository!
    private var sut: SomeClass!
    
    override
    func setUp() {
        super.setUp()
        
        someRepository = .init()
        sut = .init(repository: someRepository)
    }
    
    func test_whenReturn() {
        // Given
        let idList = ["foo", "bar",]
        
        someRepository.when(
            "getAllUserIDList()",
            isCalledReturn: idList,
            numberOfTimes: 0)
        
        // When
        XCTAssertNoThrow(try sut.doSomething())
        
        // Then
        XCTAssertEqual(sut.allUserIDList, idList)
    }
    
    func test_whenThrow() {
        // Given
        enum SomeError : Error { case test }
        let error: SomeError = .test
        
        someRepository.when(
            "getAllUserIDList()",
            isCalledThrow: error,
            numberOfTimes: 0)
        
        // When
        XCTAssertThrowsError(try sut.doSomething()) {
            XCTAssertEqual($0 as? SomeError, error)
        }
        
        // Then
        XCTAssert(sut.allUserIDList.isEmpty)
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
