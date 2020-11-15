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
        stubTable.mutate(
            key: methodName,
            defaultValue: .init())
        {
            $0.prepare(
                response: .value(returnValue),
                numberOfTimes: count)
        }
    }
    
    public func when(
        _ methodName: String,
        isCalledThrow error: Error,
        numberOfTimes count: UInt)
    {
        stubTable.mutate(
            key: methodName,
            defaultValue: .init())
        {
            $0.prepare(
                response: .error(error),
                numberOfTimes: count)
        }
    }
    
    public func when(
        _ methodName: String,
        isCalledThen execute: @escaping StubLogic,
        numberOfTimes count: UInt)
    {
        print(#function)
    }
    
    public func resetStubBehavior() {
        stubTable = [:]
    }
    
    public func stub<T>(_ methodName: String) throws -> T {
        guard var provider = stubTable[methodName], provider.canStub
        else { throw StubError.stubNotFound }
        
        let stubbedResponse = provider.stub()
        
        stubTable[methodName] = provider
        
        switch stubbedResponse {
        case .value(let value):
            guard let value = value as? T else { throw StubError.invalidStubResponse }
            return value
            
        case .error(let error): throw error
        }
    }
    
    // MARK: Private
    
    private var stubTable: [String : StubBehaviorProvider] = [:]
    
    // MARK: Initializer
    
    public init() { }
    
}
