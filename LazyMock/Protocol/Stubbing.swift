//
//  Stubbing.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

public protocol Stubbing {
    
    typealias StubLogic = ([Any]) throws -> Any
    
    /**
     Stubs the result of a method call `count` number of times. (Used by the test client code.)
  
     The behavior is accumulative, so if the client calls this method with `count` value as `2`,
     and then calls this method with a different `returnValue` with a `count` of `1`,
     the first two calls will return the first `returnValue` and the third call will return the next `returnValue` once.
     
     Subsequent calls will crash due to `nil` force-unwrapping unless a default stub value is set with `count` as `0`.
     
     The accumulative effect is shared with `when(_:isCalledThrow:numberOfTimes:)`.
     To reset the recorded stub behavior, call `resetStubBehavior()`.
     
     - Parameters:
         - methodName: The method whose result  to stub.
         - returnValue: The value to return.
         - count: The number of times to stub. Use `0` to set the default stub value.
     */
    func when(
        _ methodName: String,
        isCalledReturn returnValue: Any,
        numberOfTimes count: UInt)
    
    /**
     Stubs the throwing behavior of a method call `count` number of times. (Used by the test client code.)
     
     The behavior is accumulative, so if the client calls this method with `count` value as `2`,
     and then calls this method with a different `error` with a `count` of `1`,
     the first two calls will throw the first `error` and the third call will throw the next `error` once.
     
     Subsequent calls will crash due to `nil` force-unwrapping unless a default stub value is set with `count` as `0`.
     
     The accumulative effect is shared with `when(_:isCalledReturn:numberOfTimes:)`.
     To reset the recorded stub behavior, call `resetStubBehavior()`.
     
     - Parameters:
         - methodName: The method whose result  to stub.
         - returnValue: The value to return.
         - count: The number of times to stub. Use `0` to set the default stub value.
     */
    func when(
        _ methodName: String,
        isCalledThrow error: Error,
        numberOfTimes count: UInt)
    
    /**
     Stubs the method call using the provided code `count` number of times. (Used by the test client code.)
     
     The behavior is accumulative. (Check documentation for `when(_:isCalledReturn:numberOfTimes:)`.
     The accumulative effect is shared with all other stubbing method calls and is reset likewise.
     
     Use this method when stub behavior should be provided depending on which arguments are passed in.
     
     - Parameters:
        - methodName: The method whose result to stub.
        - execute: The code block providing the comparison and return logic.
        - count: The number of times to stub. Use `0` to set the default stub behavior.
     */
    func when(
        _ methodName: String,
        isCalledThen execute: @escaping StubLogic,
        numberOfTimes count: UInt)
    
    
    /**
     Resets the recorded stub behavior. (Used by the test client code.)
     
     Calling this resets all stubbing behavior, including the default stubbed response.
     */
    func resetStubBehavior()
    
    /**
     Provides a stubbed response to the method call. (Used by the manually mocked object.)
     
     If `when(_:isCalledThrow:numberOfTimes:)` was not invoked, no error will be thrown; i.e. it is safe to call with `try!`.
     
     - Throws: `StubError`
     */
    func stub<T>(_ methodName: String) throws -> T
    
    /**
     Provides a stubbed response to the method call. (Used by the manually mocked object.)
     
     If `when(_:isCalledThrow:numberOfTimes:)` was not invoked, no error will be thrown; i.e. it is safe to call with `try!`.
     
     - Throws: `StubError`
     */
    func stub<T>(_ methodName: String, args: [Any]) throws -> T
    
}
