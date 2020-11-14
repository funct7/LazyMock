//
//  StubBehaviorProvider.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

struct StubBehaviorProvider : StubProviding {
    
    // MARK: Interface
    
    private(set) var defaultResponse: Any?
    
    private(set) var sequentialReponse: [Any] = []
    
    /**
     Records the desired stubbed responses.
     
     This method has an accumulative effect. Reset by calling `reset()`.
     
     - Parameter numberOfTimes: `0` is used to prepare the default response.
     */
    func prepare(response: Any, numberOfTimes: UInt) {
        
    }
    
    /**
     Resets all stubbed response.
     */
    func reset() {
        
    }
    
    func stub() -> Any {
        <#code#>
    }
    
}
