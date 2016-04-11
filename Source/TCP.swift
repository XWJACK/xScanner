//
//  TCP.swift
//  xScanner
//
//  Created by 许文杰 on 4/2/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import Foundation

public func xConnectWithTCP(ipAddress:in_addr_t, _ port:UInt16/*, _ receiveTimeout:Int32*/) -> Bool {
    let socketfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    guard socketfd != -1 else { return false }
    
    //var sendTimeout = timeval(tv_sec: 2, tv_usec: 0)
    //var recvTimeout = timeval(tv_sec: Int(receiveTimeout / 1000), tv_usec: receiveTimeout % 1000)
    //guard setsockopt(socketfd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, UInt32(sizeof(timeval))) != -1 else { return false }
    //guard setsockopt(socketfd, SOL_SOCKET, SO_RCVTIMEO, &recvTimeout, UInt32(sizeof(timeval))) != -1 else { return false }
    
    var destinationIpAddress = sockaddr_in()
    xSettingIp(ipAddress, port, &destinationIpAddress)
    let destinationIpAddr = withUnsafePointer(&destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, UnsafePointer<sockaddr>.self)
    }

    guard connect(socketfd, destinationIpAddr, UInt32(sizeof(sockaddr))) != -1 else {
        //print(errno)
        return false
    }
    close(socketfd)
    return true
}