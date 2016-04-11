//
//  UDP.swift
//  xScanner
//
//  Created by 许文杰 on 4/10/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import Foundation


func xUDPSetting(inout socketfd:Int32, _ ipAddress:in_addr_t, _ port:UInt16, inout _ destinationIpAddress:sockaddr_in) -> Bool{
    var sendTimeout = timeval(tv_sec: 0, tv_usec: 100)
    
    socketfd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)
    guard socketfd != -1 else { return false }

    guard setsockopt(socketfd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, UInt32(sizeof(timeval))) != -1 else { return false }
    
    xSettingIp(ipAddress, port, &destinationIpAddress)

    return true
}


public func xSendUDP(ipAddress:in_addr_t, _ port:UInt16) -> Bool {
    var socketfd:Int32 = 0
    var destinationIpAddress = sockaddr_in()
    
    xUDPSetting(&socketfd, ipAddress, port, &destinationIpAddress)
    
    let destinationIpAddr = withUnsafePointer(&destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, UnsafePointer<sockaddr>.self)
    }

    guard sendto(socketfd, nil, 0, 0, destinationIpAddr, UInt32(sizeof(sockaddr))) != -1 else { return false }
    return true
}