//
//  NetworkLatency.swift
//  xScanner
//
//  Created by Jack on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

//import Foundation
//
///// network latency
//class NetworkLatency {
//    
//    static func ping(_ ipAddress: xIP, number: Int) -> Double {
//        guard number > 0 else { return 0 }
//        
//        var statistics = 0
//        var statisticsRoundTripTime: Double = 0.0
//        
//        for index in 0..<number {
//            let result = xPing(ipAddress, UInt16(index), 1000)
//            
//            if result.isSuccess {
//                statistics += 1
//                statisticsRoundTripTime += result.time
//            }
//        }
//        
//        return statisticsRoundTripTime / Double(statistics)
//    }
//}
//
//// MARK: - NetworkLatency with String
//extension NetworkLatency {
//    /**
//     test network latnecy
//     
//     - parameter ipAddress: ipAddress description
//     - parameter number:    number of pacekt
//     
//     - returns: average of round-trip time
//     */
//    static func ping(_ ipAddress: String, number: Int) -> Double {
//        guard number > 0 else { return 0 }
//        
//        let ipAddr = inet_addr(ipAddress)
//        let nameAddr = gethostbyname(ipAddress)
//        
//        var statistics = 0
//        var statisticsRoundTripTime: Double = 0.0
//        
//        if ipAddr != INADDR_NONE {
//            for index in 0..<number {
//                let result = xPing(ipAddr, UInt16(index), 1000)
//                if result.0 == true {
//                    statistics += 1
//                    statisticsRoundTripTime += result.2
//                }
//            }
//        } else if nameAddr != nil {
//            //TODO:
//            //            var destinationIpAddress = UnsafeMutablePointer<UInt32>.alloc(Int(ipAddr1.memory.h_length))
//            //            destinationIpAddress = unsafeBitCast(ipAddr1.memory.h_addr_list, UnsafeMutablePointer<UInt32>.self)
//            //
//            //            for index in 0..<number {
//            //                let result = xPing(destinationIpAddress.memory, UInt16(index), 1000)
//            //                if result.0 == true {
//            //                    statistics++
//            //                    statisticsRoundTripTime += result.2
//            //                }
//            //            }
//        }else { return 0 }
//        
//        return statisticsRoundTripTime / Double(statistics)
//    }
//}
