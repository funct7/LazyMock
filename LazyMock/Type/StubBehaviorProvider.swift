//
//  StubBehaviorProvider.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

struct StubBehaviorProvider : StubProviding {
    
    // MARK: Inherit - StubProviding
    
    var canStub: Bool { defaultResponse != nil || sequentialReponse.count > 0 }
    
    mutating func stub() -> StubbedResponse {
        guard sequentialReponse.count > 0 else { return defaultResponse! }
        return sequentialReponse.removeFirst()
    }
    
    
    // MARK: Interface
    
    /// Exposed for debug purposes
    private(set) var defaultResponse: StubbedResponse?
    
    /// Exposed for debug purposes
    private(set) var sequentialReponse: [StubbedResponse] = []
    
    /**
     Records the desired stubbed responses.
     
     This method has an accumulative effect. Reset by calling `reset()`.
     
     - Parameter numberOfTimes: `0` is used to prepare the default response.
     */
    mutating func prepare(response: StubbedResponse, numberOfTimes: UInt) {
        if numberOfTimes == 0 {
            defaultResponse = response
        } else {
            sequentialReponse += [StubbedResponse](
                repeating: response,
                count: Int(numberOfTimes))
        }
    }
    
    /**
     Resets all stubbed response.
     */
    mutating func reset() {
        defaultResponse = nil
        sequentialReponse = []
    }
    
}
