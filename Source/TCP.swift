//
//  TCP.swift
//  xScanner
//
//  Created by Jack on 4/2/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//


func xConnectWithTCP(_ ipAddress: xIP, _ port: xPort/*, _ receiveTimeout:Int32*/) -> Bool {
    let socketfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    if socketfd == -1 {
        assertionFailure(CommonError.createSocketError.debugDescription)
        return false
    }
    
    // Useless in TCP
    //var sendTimeout = timeval(tv_sec: 2, tv_usec: 0)
    //var recvTimeout = timeval(tv_sec: Int(receiveTimeout / 1000), tv_usec: receiveTimeout % 1000)
    //guard setsockopt(socketfd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, xTimeSize) != -1 else { return false }
    //guard setsockopt(socketfd, SOL_SOCKET, SO_RCVTIMEO, &recvTimeout, xTimeSize) != -1 else { return false }
    
    var destinationIpAddress = sockaddr_in()
    xSettingIp(ipAddress, port, &destinationIpAddress)
    let destinationIpAddr = withUnsafePointer(to: &destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, to: UnsafePointer<sockaddr>.self)
    }

    if connect(socketfd, destinationIpAddr, xKernelSocketSize) == -1 {
        return false
    }
    close(socketfd)
    return true
}
