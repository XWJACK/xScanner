//
//  xScanner.swift
//  xScanner
//
//  Created by XWJACK on 4/2/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation


@objc public protocol ResultDelegate {
    optional func icmpResultDelegate(isSuccess: Bool, ipAddress: String, roundTripTime: Double, error: String?)
}

public typealias icmpResultBlock = (isSuccess: Bool, ipAddress: String, roundTripTime: Double, error: String?) -> ()


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