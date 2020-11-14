//
//  StubProviding.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

protocol StubProviding {
    
    /**
     Tells if the precondition is met before calling `stub()`.
     
     If this value is `false`, do **NOT** call `stub()`.
     */
    var canStub: Bool { get }
    
    /**
     - Precondition: `canStub == true`.
     - Returns: The stubbed response.
     */
    mutating func stub() -> StubbedResponse
    
}
