//
//  xScanner.swift
//  xScanner
//
//  Created by Jack on 4/2/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Darwin

//MARK: - Property
public typealias xAddressInternet = in_addr_t
public typealias xPort = UInt16
public typealias xTimeout = Int32
public typealias xProcessID = UInt16
public typealias xSocket = Int32
public typealias xFamily = sa_family_t

//MARK: - Globle Socket Struct
/// protocol family
public struct xProtocolFamily {
    static let IPV4 = PF_INET
    static let IPV6 = PF_INET6
}
/// socket type
public struct xSocketType {
    static let stream = SOCK_STREAM
    static let datagram = SOCK_DGRAM
}
/// protocol type
public struct xProtocolType {
    static let tcp = IPPROTO_TCP
    static let udp = IPPROTO_UDP
}

/// Do not using sizeof(timeval)
public let xTimeSize = UInt32(MemoryLayout<xTime>.stride)
public let xSocketInternetSize = UInt32(MemoryLayout<xSocketAddress>.size)
public let xSocketSize = UInt32(MemoryLayout<xSocketAddress>.size)

//MARK: - Struct
public typealias xSocketAddress = sockaddr
public typealias xSocketAddressInternet = sockaddr_in
public typealias xSocketAddressInternet6 = sockaddr_in6
public typealias xTime = timeval

//MARK: - Function
func getCurrentProcessID() -> xProcessID {
    return UInt16(getpid())
}

// MARK: - UInt32 ip address to String ip address
public extension xAddressInternet {
    func asString() -> String? {
        return String(cString: inet_ntoa(in_addr(s_addr: self)))
    }
}

// MARK: - String to UInt32
extension String {
    func asAddress() -> xAddressInternet? {
        let ip = inet_addr(self)
        return ip != INADDR_NONE ? ip : nil
    }
}


protocol IPConvertible {
    
}

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
