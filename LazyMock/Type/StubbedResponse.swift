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
    case matcher(([Any]) -> StubbedResponse)
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
    
    var isMatcher: Bool {
        guard case .matcher = self else { return false }
        return true
    }
    
    func matchArgument(_ args: [Any]) -> StubbedResponse? {
        guard case .matcher(let matcher) = self else { return nil }
        return matcher(args)
    }
    
}
