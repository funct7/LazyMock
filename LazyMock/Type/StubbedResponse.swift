//
//  StubbedResponse.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

enum StubbedResponse {
    case value(Any)
    case error(Error)
}

extension StubbedResponse {
    
    var value: Any? {
        guard case .value(let value) = self else { return nil }
        return value
    }
    
    var error: Error? {
        guard case .error(let error) = self else { return nil }
        return error
    }
    
}
