//
//  xScanner.swift
//  xScanner
//
//  Created by Jack on 4/2/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

// MARK: - Network Latency test
extension String {
    func ping(number: Int = 1) -> Double {
        return NetworkLatency.ping(self, number: number)
    }
}



public class xScanner {
    public var ipAddress: String
    
    public func shareInstance() -> xScanner{
        return self
    }
    
    public init(ipAddress: String) {
        self.ipAddress = ipAddress
    }
}

// MARK: - icmp Scanner
public extension xScanner {
    
}