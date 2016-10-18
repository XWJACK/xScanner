//
//  Base.swift
//  xScanner
//
//  Created by Jack on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

/////  The Base function in totle framework
//
/////  But if you want to using pointer in swift.
/////  Remenber to release by your self when you don't needed, because it unsafity in swift.
//
//
///// The struct of IP Header
//public struct IP {
//    
//    /// Version and Header Length
//    var versionAndHeaderLength: UInt8
//    
//    /// different Services
//    var differentiatedServices: UInt8
//    
//    /// total Length
//    var totalLength: UInt16
//    var identification: UInt16
//    var flagsAndFragmentOffset: UInt16
//    var timeToLive: UInt8
//    var ipProtocol: UInt8
//    
//    /// header Check Sum
//    var headerCheckSum: UInt16
//    
//    /// Source Address
//    var sourceAddress: UInt32
//    
//    /// Destination Address
//    var destinationAddress: UInt32
//}
//
///// calculate check sum
/////
///// - parameter buffer: untyped data(`Void`)
///// - parameter size:   buffer size
/////
///// - returns: check sum
//public func calculateCheckSum(from buffer: UnsafeMutableRawPointer,
//                              bufferSize size: UInt16) -> UInt16 {
//    var size = size
//    var checkSum: UInt32 = 0
//    var forcedConversionBuffer = unsafeBitCast(buffer, to: UnsafeMutablePointer<UInt16>.self)
//    
//    while size > 1 {
//        checkSum += UInt32(forcedConversionBuffer.pointee)
//        forcedConversionBuffer = forcedConversionBuffer.successor()
//        size -= UInt16(MemoryLayout<UInt16>.size)
//    }
//
//    if size == 1 { checkSum += UInt32(forcedConversionBuffer.pointee) }
//
//    checkSum = (checkSum >> 16) + (checkSum & 0xFFFF)
//    checkSum += checkSum >> 16
//    return ~UInt16(checkSum)
//}
//
///// calculate time subtract from begin to end
/////
///// - parameter sendTimeStamp:    send TimeStamp
///// - parameter receiveTimeStamp: receive TimeStamp
/////
///// - returns: Time Subtract
//public func calculateTimeSubtract(from sendTimeStamp: xTime,
//                                  to receiveTimeStamp: xTime) -> Double {
//    //calculate seconds
//    var timevalSec = receiveTimeStamp.tv_sec - sendTimeStamp.tv_sec
//    //calculate microsends
//    var timevalUsec = receiveTimeStamp.tv_usec - sendTimeStamp.tv_usec
//
//    //if microsends less then zero
//    if timevalUsec < 0 {
//        timevalSec -= 1
//        timevalUsec = -timevalUsec
//    }
//    return (Double(timevalSec) * 1000.0 + Double(timevalUsec)) / 1000.0
//}
//
///// Deploy Destination Address
///// Setting `IP`, `port`, `familyType`
/////
///// - parameter ipAddress:  ipAddress
///// - parameter port:       default change to `bigEndian`
///// - parameter familyType: default is `xIPV4`
/////
///// - returns: xSocketAddressInternet
//func creatingAddress(ipAddress: xAddressInternet,
//                     port: xPort,
//                     familyType: xFamily = xProtocolFamily.IPV4) -> xSocketAddressInternet {
//    var ip = xSocketAddressInternet()
//    ip.sin_family = familyType
//    ip.sin_port = port.bigEndian
//    ip.sin_addr.s_addr = ipAddress
//    return ip
//}
