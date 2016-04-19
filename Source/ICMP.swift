//
//  ICMP.swift
//  xScanner
//
//  Created by XWJACK on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

/**
*  The struct of ICMP Header
*/
private struct icmp {
    //u_char	icmp_type;		/* type of message, see below */
    var type:UInt8
    //u_char	icmp_code;		/* type sub code */
    var code:UInt8
    //u_short	icmp_cksum;		/* ones complement cksum of struct */
    var checkSum:UInt16
    var id:UInt16
    var sequence:UInt16
    
    var data:timeval
    let fill:[UInt8] = [UInt8](count: 56 - sizeof(timeval), repeatedValue: 0x00)
    
    init() {
        self.type = 0
        self.code = 0
        self.checkSum = 0
        self.id = 0
        self.sequence = 0
        self.data = timeval()
    }
}

/**
fill icmp packet

- parameter icmpHeader:     icmpHeader
- parameter pid:            process id
- parameter packetSequence: packet Sequence
*/
private func xFillicmpPacket(inout icmpHeader:icmp, _ pid:UInt16, _ packetSequence:UInt16) {
    icmpHeader.code = 0
    icmpHeader.type = 8
    icmpHeader.checkSum = 0
    icmpHeader.id = pid.bigEndian
    icmpHeader.sequence = packetSequence
    
    gettimeofday(&icmpHeader.data, nil)
    icmpHeader.checkSum = xCheckSum(&icmpHeader, 64)
}

/**
un icmp packet

- parameter buffer:         buffer
- parameter pid:            process id
- parameter packetSequence: packetSequence
- parameter packetSize:     packetSize

- returns: result
*/
func xUnicmpPacket(buffer:UnsafeMutablePointer<Int8>, _ pid:UInt16, _ packetSequence:UInt16, _ packetSize:Int) -> (Bool, in_addr_t, Double) {
    var ipHeaderLength:UInt8 = 0
    
    let ipHeader = UnsafeMutablePointer<ip>(buffer)
    
    ipHeaderLength = ipHeader.memory.versionAndHeaderLength & 0x0F
    ipHeaderLength = ipHeaderLength << 2
    let ipAddr = ipHeader.memory.sourceAddress
 
    let icmpHeader = UnsafeMutablePointer<icmp>(buffer + Int(ipHeaderLength))
    if packetSize - Int(ipHeaderLength) < 8 { return (false, 0, 0) }

    if icmpHeader.memory.type == 0 && icmpHeader.memory.id.bigEndian == pid && icmpHeader.memory.sequence == packetSequence {
        let receiveCheckSum = icmpHeader.memory.checkSum;
        icmpHeader.memory.checkSum = 0
        let calculateCheckSum = xCheckSum(icmpHeader, UInt16(packetSize - Int(ipHeaderLength)))
        icmpHeader.memory.checkSum = receiveCheckSum
        
        if receiveCheckSum == calculateCheckSum {
            var timevalReceive = timeval()
            gettimeofday(&timevalReceive, nil)
            
            return (true, ipAddr, xTimeSubtract(&timevalReceive, &icmpHeader.memory.data))
        }else { return (false, 0, 0) }
    }else { return (false, 0, 0) }
}


//////////////////////////////////////////////////////////////////////////
/////////////////////////use for Muti thread/////////////////////////////

/**
setting socket ping

- parameter socketfd:       socketfd
- parameter receiveTimeout: receiveTimeout

- returns: Bool
*/
func xPingSetting(inout socketfd:Int32, _ receiveTimeout:Int32) -> Bool{
    var sendTimeout = timeval(tv_sec: 0, tv_usec: 100)
    var recvTimeout = timeval(tv_sec: Int(receiveTimeout / 1000), tv_usec: receiveTimeout % 1000)
    
    socketfd = socket(PF_INET, SOCK_DGRAM, IPPROTO_ICMP)
    guard socketfd != -1 else { return false }
    guard setsockopt(socketfd, SOL_SOCKET, SO_RCVTIMEO, &recvTimeout, UInt32(sizeof(timeval))) != -1 else { return false }
    guard setsockopt(socketfd, SOL_SOCKET, SO_SNDTIMEO, &sendTimeout, UInt32(sizeof(timeval))) != -1 else { return false }
    return true
}

/**
send icmp

- parameter socketfd:       socketfd
- parameter pid:            pid
- parameter ipAddress:      ipAddress
- parameter packetSequence: packetSequence

- returns: Bool
*/
func xPingSend(socketfd:Int32, _ pid:UInt16, _ ipAddress:in_addr_t, _ packetSequence:UInt16) -> Bool {
    var sendBuffer = icmp()
    xFillicmpPacket(&sendBuffer, pid, packetSequence)
    
    
    var destinationIpAddress = sockaddr_in()
    xSettingIp(ipAddress, 0, &destinationIpAddress)
    
    /// struct sockaddr_in to struct sockaddr
    let destinationIpAddr = withUnsafePointer(&destinationIpAddress) { (temp) in
        return unsafeBitCast(temp, UnsafePointer<sockaddr>.self)
    }
    guard sendto(socketfd, &sendBuffer, 64, 0, destinationIpAddr, UInt32(sizeof(sockaddr))) != -1 else { return false }

    return true
}

/**
prepare ping

- parameter socketfd:       socketfd description
- parameter pid:            pid description
- parameter ipAddress:      ipAddress description
- parameter packetSequence: packetSequence description
- parameter receiveTimeout: receiveTimeout description

- returns: Bool
*/
func xPingPrepare(inout socketfd:Int32, _ pid:UInt16, _ ipAddress:in_addr_t, _ packetSequence:UInt16, _ receiveTimeout:Int32) -> Bool {

    guard xPingSetting(&socketfd, receiveTimeout) == true else { return false }
    
    //var context = CFSocketContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
    //let callback:CFSocketCallBack = {(s, type, address, data, info) -> Void in
        
    //}
    //guard let socketfd = CFSocketCreate(nil, PF_INET, SOCK_DGRAM, IPPROTO_ICMP, CFSocketCallBackType.AcceptCallBack.rawValue, callback, &context) else { return false }
    //let cfsocketfd:CFSocketRef = CFSocketCreateWithNative(nil, socketfd, CFSocketCallBackType.AcceptCallBack.rawValue, callback, &context)
    guard xPingSend(socketfd, pid, ipAddress, packetSequence) == true else { return false }
    return true
}

/**
receive result

- parameter socketfd:      socketfd description
- parameter receiveBuffer: receiveBuffer description

- returns: Bool
*/
func xPingReceive(socketfd:Int32, _ receiveBuffer:UnsafeMutablePointer<Int8>) -> Bool {
    guard recvfrom(socketfd, receiveBuffer, 84, 0, nil, nil) != -1 else { return false }
    return true
}


/////////////////////////use for Muti thread/////////////////////////////
//////////////////////////////////////////////////////////////////////////


/**
ping

- parameter ipAddress:      ipAddress description
- parameter packetSequence: packetSequence description
- parameter receiveTimeout: receiveTimeout description

- returns: result
*/
public func xPing(ipAddress:in_addr_t, _ packetSequence:UInt16, _ receiveTimeout:Int32) -> (Bool, in_addr_t, Double) {
    var socketfd:Int32 = 0
    let pid = UInt16(getpid())
    
    guard xPingPrepare(&socketfd, pid, ipAddress, packetSequence, receiveTimeout) == true else { return (false, ipAddress, 0) }
    
    let receiveBuffer = UnsafeMutablePointer<Int8>.alloc(84)
    receiveBuffer.initialize(0)
    guard xPingReceive(socketfd, receiveBuffer) == true else { return (false, ipAddress, 0) }
    
    let result = xUnicmpPacket(receiveBuffer, pid, packetSequence, 84)
    
    close(socketfd)
    receiveBuffer.destroy()
    receiveBuffer.dealloc(84)
    return result
}

