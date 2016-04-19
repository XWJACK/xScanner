//
//  Base.swift
//  xScanner
//
//  Created by XWJACK on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

/**
*  The struct of IP Header
*/
struct ip {
    var versionAndHeaderLength:UInt8
    var differentiatedServices:UInt8
    var totalLength:UInt16
    var identification:UInt16
    var flagsAndFragmentOffset:UInt16
    var timeToLive:UInt8
    var ipProtocol:UInt8
    var headerCheckSum:UInt16
    var sourceAddress:UInt32
    var destinationAddress:UInt32
}

/**
calculate checksum

- parameter buffer: buffer
- parameter size:   size

- returns: checksum
*/
func xCheckSum(buffer:UnsafeMutablePointer<Void>, var _ size:UInt16) -> UInt16 {
    var checksum:UInt32 = 0
    var buf = UnsafeMutablePointer<UInt16>(buffer)
    
    while size > 1 {
        checksum += UInt32(buf.memory)
        buf = buf.successor()
        size -= UInt16(sizeof(UInt16))
    }
    
    if size == 1 {
        checksum += UInt32(UnsafeMutablePointer<UInt16>(buf).memory)
    }
    checksum = (checksum >> 16) + (checksum & 0xFFFF)
    checksum += checksum >> 16
    return ~UInt16(checksum)
}


/**
Calculate time subtract

- parameter recvTimeStamp: receive time stamp
- parameter sendTimeStamp: send time stamp

- returns: microsencond
*/
func xTimeSubtract(recvTimeStamp:UnsafeMutablePointer<timeval>, _ sendTimeStamp:UnsafeMutablePointer<timeval>) -> Double {
    //calculate seconds
    var timevalSec = recvTimeStamp.memory.tv_sec - sendTimeStamp.memory.tv_sec
    //calculate microsends
    var timevalUsec = recvTimeStamp.memory.tv_usec - sendTimeStamp.memory.tv_usec
    
    //if microsends less then zero
    if timevalUsec < 0 {
        timevalSec--
        timevalUsec = -timevalUsec
    }
    return (Double(timevalSec) * 1000.0 + Double(timevalUsec)) / 1000.0
}

/**
setting ip Address

- parameter ipAddr:  ip Address
- parameter port:    destination port
- parameter dstAddr: destination ip Address
*/
func xSettingIp(ipAddr:in_addr_t, _ port:UInt16 , _ dstAddr:UnsafeMutablePointer<sockaddr_in>) {
    bzero(dstAddr, sizeof(sockaddr_in));/* do not use sizeof(dstAddr) */
    dstAddr.memory.sin_family = UInt8(AF_INET);
    dstAddr.memory.sin_port = port.bigEndian
    dstAddr.memory.sin_addr.s_addr = ipAddr
}
