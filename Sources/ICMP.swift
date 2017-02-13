//
//  ICMP.swift
//  xScanner
//
//  Created by Jack on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

//import Darwin
//
//private let icmpHeadSize = 8
//
//private let icmpDataSize = 56
//
//private let ipHeadSize = 20
//
//private let icmpPacketSize = icmpHeadSize + icmpDataSize    //64
//
///// receive packet is ip head with icmp packet
//let recvPacketSize = ipHeadSize + icmpPacketSize


/// The struct of ICMP Header
public struct ICMP {
    /// type of message
    var type: UInt8 = 0
    /// type sub code
    var code: UInt8 = 0
    /// check sum
    var checkSum: UInt16 = 0
    /// Default is process id
    var id: xProcessID = 0
    var sequence: UInt16 = 0

    var data: UnsafeMutableBufferPointer<UInt8>?
}


///// Send ICMP pakcet and return result
////typealias icmpReuslt = (isSuccess: Bool, ipAddress: xAddressInternet, time: Double, errorType: ICMPError?)
//
//
///**
//create icmp packet
//
//- parameter icmpHeader:     icmpHeader
//- parameter pid:            process id
//- parameter packetSequence: packet Sequence
//*/
//private func xFillICMPPacket(_ icmpHeader: inout ICMP, _ pid: xProcessID, _ packetSequence: UInt16) {
//
//    gettimeofday(icmpHeader.data, nil)
//    icmpHeader.checkSum = calculateCheckSum(from: &icmpHeader, bufferSize: 64)
//}
//
//func creatingICMP(code: UInt8 = 0,
//                  type: UInt8 = 8,
//                  id: xProcessID = getCurrentProcessID(),
//                  sequence: UInt16,
//                  currentTime: xTime = xTime()) -> ICMP {
//    var icmp = ICMP()
//    icmp.code = code
//    icmp.type = type
//    icmp.checkSum = 0
//    icmp.id = id
//    icmp.sequence = sequence
//    icmp.data
//}
//
//
///**
//un icmp packet
//
//- parameter buffer:         buffer
//- parameter pid:            process id
//- parameter packetSequence: packetSequence
//- parameter packetSize:     packetSize
//
//- returns: result, if result.0 is false: return (false, 0, 0)
//*/
//func xUnICMPPacket(_ buffer: UnsafeMutablePointer<Int8>, _ pid: xProcessID, _ packetSequence: UInt16, _ packetSize: Int) -> icmpReuslt {
//    var ipHeaderLength: UInt8 = 0
//
//    let ipHeader = UnsafeMutablePointer<IP>(buffer)
//
//    ipHeaderLength = ipHeader.pointee.versionAndHeaderLength & 0x0F
//    ipHeaderLength = ipHeaderLength << 2
//    let ipAddr = ipHeader.pointee.sourceAddress
//
//    let icmpHeader = UnsafeMutablePointer<ICMP>(buffer + Int(ipHeaderLength))
//    if packetSize - Int(ipHeaderLength) < 8 {
//        assertionFailure(ICMPError.unPacketError.debugDescription + " with packet size Error")
//        return (false, 0, 0, .unPacketError)
//    }
//
//    // delete icmpHeader.memory.sequence == packetSequence
//    // Useless in Multithreading
//    if icmpHeader.pointee.type == 0 && icmpHeader.pointee.id.bigEndian == pid/* && icmpHeader.memory.sequence == packetSequence */{
//        let receiveCheckSum = icmpHeader.pointee.checkSum
//        icmpHeader.pointee.checkSum = 0
//        let calculateCheckSum = xCheckSum(icmpHeader, UInt16(packetSize - Int(ipHeaderLength)))
//        icmpHeader.pointee.checkSum = receiveCheckSum
//
//        if receiveCheckSum == calculateCheckSum {
//            var timevalReceive = timeval()
//            gettimeofday(&timevalReceive, nil)
//
//            return (true, ipAddr, xTimeSubtract(&timevalReceive, &icmpHeader.pointee.data), nil)
//        } else {
//            assertionFailure(ICMPError.unPacketError.debugDescription + " with receive checkSum Error")
//            return (false, 0, 0, .unPacketError)
//        }
//    } else {
//        assertionFailure(ICMPError.unPacketError.debugDescription + " with icmpHeader type or pid Error")
//        return (false, 0, 0, .unPacketError)
//    }
//}
//
//
////////////////////////////////////////////////////////////////////////////
///////////////////////////use for Multithreading///////////////////////////
//
///**
//setting socketfd , send timeout and receive timeout
//
//- parameter socketfd:       socketfd
//- parameter receiveTimeout: receiveTimeout
//
//- returns: true if success
//*/
//func xPingSetting(_ socketfd: inout xSocket, _ receiveTimeout: xTimeout) -> Bool {
//    //var sendTimeout = timeval(tv_sec: 0, tv_usec: 100)
//    var recvTimeout = timeval(tv_sec: Int(receiveTimeout / 1000), tv_usec: receiveTimeout % 1000)
//
//    socketfd = socket(PF_INET, SOCK_DGRAM, IPPROTO_ICMP)
//    if socketfd == -1 {
//        assertionFailure(CommonError.createSocketError.debugDescription)
//        return false
//    }
//    // why using strideof but not sizeof: https://forums.developer.apple.com/thread/14959
//    if setsockopt(socketfd, SOL_SOCKET, SO_RCVTIMEO, &recvTimeout, xTimeSize) == -1 {
//        assertionFailure(CommonError.settingSocketError.debugDescription + " with set receive timeout Error")
//        return false
//    }
////    if setsockopt(socketfd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, xTimeSize) == -1 {
////        assertionFailure(ICMPError.settingSocketError.debugDescription + " with set send timeout Error")
////        return false
////    }
//    return true
//}
//
///**
//send icmp
//
//- parameter socketfd:       socketfd
//- parameter pid:            pid
//- parameter ipAddress:      ipAddress
//- parameter packetSequence: packetSequence
//
//- returns: true if success
//*/
//func xPingSend(_ socketfd: xSocket, _ pid: xProcessID, _ ipAddress: xAddressInternet, _ packetSequence: UInt16) -> Bool {
//    var sendBuffer = ICMP()
//    xFillICMPPacket(&sendBuffer, pid, packetSequence)
//
//    var destinationIpAddress = sockaddr_in()
//    deploy(ipAddress, 0, &destinationIpAddress)
//
//    /// struct sockaddr_in to struct sockaddr
//    let destinationIpAddr = withUnsafePointer(to: &destinationIpAddress) { (temp) in
//        return unsafeBitCast(temp, to: UnsafePointer<sockaddr>.self)
//    }
//    if sendto(socketfd, &sendBuffer, icmpPacketSize, 0, destinationIpAddr, xSocketSize) == -1 {
//        assertionFailure(ICMPError.sendError.debugDescription)
//        return false
//    }
//
//    return true
//}
//
///**
//setting and send
//
//- parameter socketfd:       socketfd
//- parameter pid:            pid
//- parameter ipAddress:      ipAddress
//- parameter packetSequence: packetSequence
//- parameter receiveTimeout: receiveTimeout
//
//- returns: true if success
//*/
//func xPingPrepare(_ socketfd: inout xSocket, _ pid: xProcessID, _ ipAddress: xAddressInternet, _ packetSequence: UInt16, _ receiveTimeout: xTimeout) -> Bool {
//
//    if !xPingSetting(&socketfd, receiveTimeout) { return false }
//
//    //var context = CFSocketContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
//    //let callback:CFSocketCallBack = {(s, type, address, data, info) -> Void in
//
//    //}
//    //guard let socketfd = CFSocketCreate(nil, PF_INET, SOCK_DGRAM, IPPROTO_ICMP, CFSocketCallBackType.AcceptCallBack.rawValue, callback, &context) else { return false }
//    //let cfsocketfd:CFSocketRef = CFSocketCreateWithNative(nil, socketfd, CFSocketCallBackType.AcceptCallBack.rawValue, callback, &context)
//    if !xPingSend(socketfd, pid, ipAddress, packetSequence) { return false }
//    return true
//}
//
///**
//receive result
//
//- parameter socketfd:      socketfd
//- parameter receiveBuffer: receiveBuffer
//
//- returns: true if success
//*/
//func xPingReceive(_ socketfd: xSocket, _ receiveBuffer: UnsafeMutablePointer<Int8>) -> Bool {
//    if recvfrom(socketfd, receiveBuffer, recvPacketSize, 0, nil, nil) == -1 {
//        //assertionFailure(ICMPError.receiveError.debugDescription)
//        return false
//    }
//    return true
//}
//
//
///////////////////////////use for Multithreading///////////////////////////
////////////////////////////////////////////////////////////////////////////
//
//
///**
//ping
//
//- parameter ipAddress:      ipAddress
//- parameter packetSequence: packetSequence
//- parameter receiveTimeout: receiveTimeout
//
//- returns: result, if result.0 is false: return (false, 0, 0)
//*/
//func xPing(_ ipAddress: xIP, _ packetSequence: UInt16, _ receiveTimeout: xTimeout) -> icmpReuslt {
//    var socketfd: xSocket = 0
//    let pid = getProcessID()
//
//    if !xPingPrepare(&socketfd, pid, ipAddress, packetSequence, receiveTimeout) { return (false, ipAddress, 0, .sendError) }
//
//    let receiveBuffer = UnsafeMutablePointer<Int8>.allocate(capacity: recvPacketSize)
//    receiveBuffer.initialize(to: 0)
//    
//    if !xPingReceive(socketfd, receiveBuffer) { return (false, ipAddress, 0, .receiveError) }
//
//    let result = xUnICMPPacket(receiveBuffer, pid, packetSequence, recvPacketSize)
//
//    close(socketfd)
//    receiveBuffer.deinitialize()
//    receiveBuffer.deallocate(capacity: recvPacketSize)
//    return result
//}



//import CoreFoundation
//
//func createICMP() {
//    let socketFileHandle = CFSocketCreate(nil, xProtocolFamily.IPV4, xSocketType.datagram, xProtocolType.udp, CFSocketCallBackType.acceptCallBack.rawValue, { (socket, callbackType, address, data, info) in
//        }, nil)
//}
