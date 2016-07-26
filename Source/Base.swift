//
//  Base.swift
//  xScanner
//
//  Created by Jack on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

//  The Base function in totle framework

//  But if you want to using pointer in swift.
//  Remenber to release by your self when you don't needed, because is unsafe in swift.

typealias xIP = in_addr_t
typealias xPort = UInt16
typealias xTimeout = Int32
typealias xPid = UInt16
typealias xSocket = Int32

/// Do not using sizeof(timeval)
let xTimeSize = UInt32(strideof(timeval))
let xNetworkSocketSize = UInt32(sizeof(sockaddr_in))
let xKernelSocketSize = UInt32(sizeof(sockaddr))
let xIPV4 = UInt8(AF_INET)

/**
*  The struct of IP Header
    In addition to we can using #import "ip.h" in xScanner.h
    This file is exist in:
    /Applications/Xcode.app/Contents/Developer/Platforms/   iPhoneSimulator.platform (iPhoneOS.platform)
    /Developer/SDKs/                                        iPhoneSimulator.sdk      (iPhoneOS.sdk)
    /usr/include/netinet/ip.h
*/
struct IP {
    var versionAndHeaderLength: UInt8
    var differentiatedServices: UInt8
    var totalLength: UInt16
    var identification: UInt16
    var flagsAndFragmentOffset: UInt16
    var timeToLive: UInt8
    var ipProtocol: UInt8
    var headerCheckSum: UInt16
    var sourceAddress: UInt32
    var destinationAddress: UInt32
}

/**
calculate checksum to check pack is correct

- parameter buffer: buffer
- parameter size:   buffer size

- returns: checksum with Unsigned Int 16 bytes
*/
func xCheckSum(buffer: UnsafeMutablePointer<Void>, var _ size: UInt16) -> UInt16 {
    var checkSum: UInt32 = 0
    var buff = UnsafeMutablePointer<UInt16>(buffer)

    while size > 1 {
        checkSum += UInt32(buff.memory)
        buff = buff.successor()
        size -= UInt16(sizeof(UInt16))
    }

    if size == 1 { checkSum += UInt32(buff.memory) }

    checkSum = (checkSum >> 16) + (checkSum & 0xFFFF)
    checkSum += checkSum >> 16
    return ~UInt16(checkSum)
}


/**
Calculate time subtract

- parameter receiveTimeStamp: receive time stamp
- parameter sendTimeStamp: send time stamp

- returns: time with number of microsencond
*/
func xTimeSubtract(receiveTimeStamp: UnsafeMutablePointer<timeval>, _ sendTimeStamp: UnsafeMutablePointer<timeval>) -> Double {
    //calculate seconds
    var timevalSec = receiveTimeStamp.memory.tv_sec - sendTimeStamp.memory.tv_sec
    //calculate microsends
    var timevalUsec = receiveTimeStamp.memory.tv_usec - sendTimeStamp.memory.tv_usec

    //if microsends less then zero
    if timevalUsec < 0 {
        timevalSec -= 1
        timevalUsec = -timevalUsec
    }
    return (Double(timevalSec) * 1000.0 + Double(timevalUsec)) / 1000.0
}

/**
setting ip Address

- parameter ipAddress:  ip Address
- parameter port:    destination port
- parameter destinationAddress: destination ip Address
*/
func xSettingIp(ipAddress: xIP, _ port: xPort, _ destinationAddress: UnsafeMutablePointer<sockaddr_in>) {
    bzero(destinationAddress, sizeof(sockaddr_in));/* do not use sizeof(dstAddr) */
    destinationAddress.memory.sin_family = xIPV4
    destinationAddress.memory.sin_port = port.bigEndian
    destinationAddress.memory.sin_addr.s_addr = ipAddress
}

/**
 Get Process ID
 
 - returns: xPid
 */
func xGetPid() -> xPid {
    return UInt16(getpid())
}

///**
// Get Thread ID
// 
// - returns: xTid
// */
//func xGetTid() -> xTid {
//    return
//}

// MARK: - UInt32 ip address to String ip address
extension xIP {
    func toString() -> String? {
        return String.fromCString(inet_ntoa(in_addr(s_addr: self)))
    }
}

// MARK: - String to UInt32
extension String {
    func toxIP() -> xIP? {
        let ip = inet_addr(self)
        return ip != INADDR_NONE ? ip : nil
    }
}
