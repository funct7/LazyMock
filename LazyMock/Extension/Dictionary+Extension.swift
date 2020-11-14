//
//  Dictionary+Extension.swift
//  LazyMock
//
//  Created by Josh Woomin Park on 2020/11/14.
//

import Foundation

extension Dictionary {
    
    mutating func mutate(
        key: Key,
        defaultValue: Value,
        mutation: (inout Value) -> Void)
    {
        var value = self[key] ?? defaultValue
        mutation(&value)
        self[key] = value
    }
    
}
