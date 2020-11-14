//
//  BaseStubClassTests.swift
//  LazyMockTests
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import XCTest
import LazyMock

class BaseStubClassTests : XCTestCase {
    
    override
    func setUp() {
        super.setUp()
    }
    
}

private class SomeClass {
    
    // MARK: Interface
    
    private(set) var allUserIDList: [String] = []
    
    /**
     Fetches the full list of user IDs.
     */
    func doSomething() {
        allUserIDList = repository.getAllUserIDList()
    }
    
    /**
     Creates a new user ID and refreshes `allUserIDList`.
     */
    func doSomethingElse() throws {
        try repository.createUser(id: UUID().uuidString)
        doSomething()
    }
    
    // MARK: Private
    
    private let repository: SomeRepository
    
    // MARK: Init
    
    init(repository: SomeRepository) {
        self.repository = repository
    }
    
}

private protocol SomeRepository : class {
    
    func getAllUserIDList() -> [String]
    
    func createUser(id: String) throws
    
}

private class StubRepository : BaseStubClass, SomeRepository {
    
    func getAllUserIDList() -> [String] {
        print(#function)
        return []
    }
    
    func createUser(id: String) throws {
        print(#function)
    }
    
}
