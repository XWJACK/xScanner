//
//  WOL.swift
//  xScanner
//
//  Created by Jack on 4/9/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//


private let wolPacketSize = 102

/**
wake a computer in LAN

- parameter boardcastAddress:      Current or Target Computer Boardcast Address
- parameter destinationMACAddress: Destination MAC Address
- parameter port:                  Destination Port, Any Port can do, default is 666

- returns: true if success
*/
func xWakeOnLAN(_ boardcastAddress: xIP, destinationMACAddress: [UInt8], port: xPort? = 666) -> Bool {
    guard destinationMACAddress.count == 6 else { return false }

    let sendBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: wolPacketSize)
    var buffer = sendBuffer

    for _ in 0..<6 {
        buffer.pointee = 0xFF
        buffer = buffer.successor()
    }
    for i in 0..<96 {
        buffer.pointee = destinationMACAddress[i % 6]
        buffer = buffer.successor()
    }

    var socketfd: xSocket = 0
    var destinationIpAddress = sockaddr_in()

    if !xUDPSetting(&socketfd, boardcastAddress, port!, &destinationIpAddress) {
        assertionFailure(UDPError.sendError.debugDescription)
        return false
    }
    var enable = 1
    setsockopt(socketfd, SOL_SOCKET, SO_BROADCAST, &enable, UInt32(MemoryLayout.size(ofValue: enable)))

    let temp = withUnsafePointer(to: &destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, to: UnsafePointer<sockaddr>.self)
    }

    // send 4 packets
    for _ in 0..<4 {
        if sendto(socketfd, sendBuffer, wolPacketSize, 0, temp, xNetworkSocketSize) == -1 {
            assertionFailure(UDPError.sendError.debugDescription)
            return false
        }
    }

    sendBuffer.deinitialize()
    sendBuffer.deallocate(capacity: wolPacketSize)
    return true
}
