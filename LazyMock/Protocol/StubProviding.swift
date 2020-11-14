//
//  StubProviding.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

protocol StubProviding {
    
    /**
     - Returns: The stubbed response.
     */
    mutating func stub() -> StubbedResponse
    
}
