//
//  BaseStubClass.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

open class BaseStubClass : Stubbing {
    
    // MARK: Inherit - Stubbing
    
    public func when(
        _ methodName: String,
        isCalledReturn returnValue: Any,
        numberOfTimes count: UInt)
    {
        fatalError("TODO")
    }
    
    public func when(
        _ methodName: String,
        isCalledThrow error: Error,
        numberOfTimes count: UInt)
    {
        fatalError("TODO")
    }
    
    public func resetStubBehavior() {
        fatalError("TODO")
    }
    
    public func stub<T>(_ methodName: String) throws -> T? {
        fatalError("TODO")
    }
    
    // MARK: Private
    
}
