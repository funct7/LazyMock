//
//  DictionaryExtensionTests.swift
//  LazyMockTests
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import XCTest
@testable import LazyMock

class DictionaryExtensionTests : XCTestCase {
    
    func test_mutate_nil() {
        // Given
        var sut: [String : Int] = [:]
        let key = UUID().uuidString
        let defaultValue = 0
        let mutation: (inout Int) -> Void = { $0 += 10 }
        let expected = 10
        
        // When
        sut.mutate(
            key: key,
            defaultValue: defaultValue,
            mutation: mutation)
        
        // Then
        XCTAssertEqual(sut[key], expected)
    }
    
    func test_mutate_existing() {
        // Given
        var sut: [String : Int] = [:]
        let key = UUID().uuidString
        let existingValue = 41
        let defaultValue = 0
        let mutation: (inout Int) -> Void = { $0 += 10 }
        let expected = 51
        
        sut[key] = existingValue

        // When
        sut.mutate(
            key: key,
            defaultValue: defaultValue,
            mutation: mutation)
        
        // Then
        XCTAssertEqual(sut[key], expected)
    }
    
}
