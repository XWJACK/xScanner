//
//  UDP.swift
//  xScanner
//
//  Created by Jack on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//


/**
 setting udp packet
 
 - parameter socketfd:             socketfd
 - parameter ipAddress:            ipAddress
 - parameter port:                 port
 - parameter destinationIpAddress: destinationIpAddress
 
 - returns: true if success
 */
func xUDPSetting( socketfd: inout xSocket, _ ipAddress: xIP, _ port: xPort, _ destinationIpAddress: inout sockaddr_in) -> Bool {
    //var sendTimeout = timeval(tv_sec: 0, tv_usec: 100)
    
    socketfd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)
    if socketfd == -1 {
        assertionFailure(CommonError.createSocketError.debugDescription)
        return false
    }

//    if setsockopt(socketfd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, xTimeSize) == -1 {
//        assertionFailure(CommonError.settingSocketError.debugDescription)
//        return false
//    }
    
    xSettingIp(ipAddress, port, &destinationIpAddress)

    return true
}

/**
 send udp packet
 
 - parameter ipAddress: ipAddress
 - parameter port:      port
 
 - returns: true if success
 */
func xSendUDP(ipAddress: xIP, _ port: xPort) -> Bool {
    var socketfd: xSocket = 0
    var destinationIpAddress = sockaddr_in()
    
    xUDPSetting(&socketfd, ipAddress, port, &destinationIpAddress)
    
    let destinationIpAddr = withUnsafePointer(&destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, to: UnsafePointer<sockaddr>.self)
    }

    if sendto(socketfd, nil, 0, 0, destinationIpAddr, xKernelSocketSize) == -1 {
        assertionFailure(UDPError.sendError.debugDescription)
        return false
    }
    return true
}
