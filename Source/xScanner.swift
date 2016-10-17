//
//  xScanner.swift
//  xScanner
//
//  Created by Jack on 4/2/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Darwin

/// property
public typealias xAddressInternet = in_addr_t
public typealias xPort = UInt16
public typealias xTimeout = Int32
public typealias xProcessID = UInt16
public typealias xSocket = Int32

public let xIPV4 = UInt8(AF_INET)
public let xIPV6 = UInt8(AF_INET6)

/// Do not using sizeof(timeval)
public let xTimeSize = UInt32(MemoryLayout<xTime>.stride)
public let xSocketInternetSize = UInt32(MemoryLayout<xSocketAddress>.size)
public let xSocketSize = UInt32(MemoryLayout<xSocketAddress>.size)
/// struct
public typealias xSocketAddress = sockaddr
public typealias xSocketAddressInternet = sockaddr_in
public typealias xSocketAddressInternet6 = sockaddr_in6
public typealias xTime = timeval

//public protocol HostStringConvertible {
//    var hostString: String { get }
//}
//
//
//extension String: HostStringConvertible {
//    public var hostString: String {
//        return self
//    }
//}
//
//extension String {
//    func ping(_ number: Int = 1) -> Double {
//        return NetworkLatency.ping(self, number: number)
//    }
//}
//
//
//public class xScanner {
//    public var ipAddress: String
//    
//    public func shareInstance() -> xScanner{
//        return self
//    }
//    
//    public init(ipAddress: String) {
//        self.ipAddress = ipAddress
//    }
//}
//
//// MARK: - icmp Scanner
//public extension xScanner {
//    
//}
//
//@objc public protocol ResultDelegate {
//    @objc optional func icmpResultDelegate(_ isSuccess: Bool, ipAddress: String, roundTripTime: Double, error: String?)
//}
//
//public typealias icmpResultBlock = (_ isSuccess: Bool, _ ipAddress: String, _ roundTripTime: Double, _ error: String?) -> ()
