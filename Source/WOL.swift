//
//  WOL.swift
//  xScanner
//
//  Created by XWJACK on 4/9/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

/**
weak a computer

- parameter boardcastAddress:      boardcastAddress description
- parameter destinationMACAddress: destinationMACAddress description
- parameter port:                  port description

- returns: Bool
*/
public func xWeakOnLAN(boardcastAddress:in_addr_t, destinationMACAddress:[UInt8], port:UInt16? = 666) -> Bool {
    guard destinationMACAddress.count == 6 else { return false }
    
    let sendBuffer = UnsafeMutablePointer<UInt8>.alloc(102)
    var buffer = sendBuffer
    
    for _ in 0..<6 {
        buffer.memory = 0xFF
        buffer = buffer.successor()
    }
    for i in 0..<96 {
        buffer.memory = destinationMACAddress[i % 6]
        buffer = buffer.successor()
    }
    
    var socketfd:Int32 = 0
    var destinationIpAddress = sockaddr_in()
    
    xUDPSetting(&socketfd, boardcastAddress, port!, &destinationIpAddress)
    var enable = 1
    setsockopt(socketfd, SOL_SOCKET, SO_BROADCAST, &enable, UInt32(sizeofValue(enable)))
    
    let temp = withUnsafePointer(&destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, UnsafePointer<sockaddr>.self)
    }
    
    guard sendto(socketfd, sendBuffer, 102, 0, temp, UInt32(sizeof(sockaddr_in))) != -1 else { return false }
    guard sendto(socketfd, sendBuffer, 102, 0, temp, UInt32(sizeof(sockaddr_in))) != -1 else { return false }
    guard sendto(socketfd, sendBuffer, 102, 0, temp, UInt32(sizeof(sockaddr_in))) != -1 else { return false }
    guard sendto(socketfd, sendBuffer, 102, 0, temp, UInt32(sizeof(sockaddr_in))) != -1 else { return false }

    sendBuffer.destroy()
    sendBuffer.dealloc(102)
    return true
}