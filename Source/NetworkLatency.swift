//
//  NetworkLatency.swift
//  xScanner
//
//  Created by XWJACK on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

/// network latency
public class NetworkLatency {
    /**
    test network latnecy
    
    - parameter ipAddress: ipAddress description
    - parameter number:    number of pacekt
    
    - returns: average of round-trip time
    */
    public static func ping(ipAddress:String, number:Int) -> Double {
        guard number > 0 else { return 0 }
        let ipAddr = inet_addr(ipAddress)
        let ipAddr1 = gethostbyname(ipAddress)
        
        var statistics = 0
        var statisticsRoundTripTime:Double = 0.0
        
        if ipAddr != INADDR_NONE {
            for index in 0..<number {
                let result = xPing(ipAddr, UInt16(index), 1000)
                if result.0 == true {
                    statistics++
                    statisticsRoundTripTime += result.2
                }
            }
        }else if  ipAddr1 != nil {
            
//            var destinationIpAddress = UnsafeMutablePointer<UInt32>.alloc(Int(ipAddr1.memory.h_length))
//            destinationIpAddress = unsafeBitCast(ipAddr1.memory.h_addr_list, UnsafeMutablePointer<UInt32>.self)
//            
//            for index in 0..<number {
//                let result = xPing(destinationIpAddress.memory, UInt16(index), 1000)
//                if result.0 == true {
//                    statistics++
//                    statisticsRoundTripTime += result.2
//                }
//            }
        }else { return 0 }
        
        return statisticsRoundTripTime / Double(statistics)
    }
}