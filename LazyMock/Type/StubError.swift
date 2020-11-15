//
//  StubError.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/15.
//

import Foundation

public enum StubError : LocalizedError {
    /// Stub behavior not defined.
    case stubNotFound
    /// Stubbed response does not match the desired return type.
    case invalidStubResponse
}
