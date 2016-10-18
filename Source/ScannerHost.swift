//
//  Scanner.swift
//  xSocket
//
//  Created by Jack on 3/20/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

//import Foundation
//
//
//class ScannerHost {
//    
//    private var xIpAddress: [xIP]
//    weak var delegate: ResultDelegate?
//    
////    public var ipAddress: [String] {
////        get {
////            return xIpAddress.map{ $0.toString() }
////        }
////        set {
////            //TODO:
////            for i in 0 ..< newValue.count { xIpAddress[i] = inet_addr(newValue[i]) }
////        }
////    }
//    
//    init(ipAddress: [xIP], delegate: ResultDelegate? = nil) {
//        self.xIpAddress = ipAddress
//        self.delegate = delegate
//    }
//}
//
//// MARK: - Scanner Host by icmp packet
//extension ScannerHost {
//    /**
//     send icmp with loop and it will block when receive result
//     
//     - parameter timeout: timeout
//     - parameter block:   result block
//     */
//    func xicmpScannerWithAllHost(_ timeout: xTimeout? = 1000, block: icmpResultBlock) {
//        
//        var socketfd: xSocket = 0
//        let pid = xGetPid()
//        if !xPingSetting(&socketfd, timeout!) { return }
//        
//        let isReadyToReceiveResult = DispatchSemaphore(value: 1)
//        //TODO:
//        isReadyToReceiveResult.wait(timeout: DispatchTime.distantFuture)
//        DispatchQueue.global(priority: 0).async(execute: {
//            isReadyToReceiveResult.signal()
//            sleep(10)
//            NSLog("Begin send packet to Scanner")
//            for (sequence, ipAddr) in self.xIpAddress.enumerated() {
//                xPingSend(socketfd, pid, ipAddr, UInt16(sequence))
//            }
//        })
//        isReadyToReceiveResult.wait(timeout: DispatchTime.distantFuture)
//        NSLog("Begin receive packet")
//        let receiveBuffer = UnsafeMutablePointer<Int8>.allocate(capacity: recvPacketSize)
//        receiveBuffer.initialize(to: 0)
//        while true {
//            if !xPingReceive(socketfd, receiveBuffer) { break }
//            let result = xUnICMPPacket(receiveBuffer, pid, 0, recvPacketSize)
//            if result.isSuccess {
//                block(isSuccess: true, ipAddress: result.ipAddress.toString()!, roundTripTime: result.time, error: nil)
//            }else {
//                assertionFailure(result.errorType.debugDescription)
//                block(isSuccess: false, ipAddress: result.ipAddress.toString()!, roundTripTime: result.time, error: result.errorType?.description)
//            }
//            receiveBuffer.initialize(to: 0)
//        }
//        close(socketfd)
//        receiveBuffer.deinitialize()
//        receiveBuffer.deallocate(capacity: recvPacketSize)
//    }
//    
//    /**
//     icmp scanner with broadcast and it will block when receive result
//     
//     - parameter broadcastIpAddress: broadcastIpAddress
//     - parameter timeout:            timeout
//     - parameter delegate:           result delegate
//     - parameter block:              result block
//     */
//    private static func xicmpScanner(_ broadcastIpAddress: xIP, _ timeout: xTimeout, _ delegate: ResultDelegate?, _ block: icmpResultBlock?) {
//        
//        var socketfd: xSocket = 0
//        let pid = xGetPid()
//        
//        if !xPingPrepare(&socketfd, pid, broadcastIpAddress, 0, timeout) { return }
//        
//        let receiveBuffer = UnsafeMutablePointer<Int8>.allocate(capacity: recvPacketSize)
//        receiveBuffer.initialize(to: 0)
//        
//        while true {
//            if !xPingReceive(socketfd, receiveBuffer) { break }
//            let result = xUnICMPPacket(receiveBuffer, pid, 0, recvPacketSize)
//            if result.isSuccess {
//                if let icmpBlock = block {
//                    icmpBlock(isSuccess: true, ipAddress: result.ipAddress.toString()!, roundTripTime: result.time, error: nil)
//                }
//                if let icmpDelegate = delegate {
//                    icmpDelegate.icmpResultDelegate!(true, ipAddress: result.ipAddress.toString()!, roundTripTime: result.time, error: nil)
//                }
//            } else {
//                assertionFailure(result.errorType.debugDescription)
//                if let icmpBlock = block {
//                    icmpBlock(isSuccess: false, ipAddress: result.ipAddress.toString()!, roundTripTime: result.time, error: result.errorType?.description)
//                }
//                if let icmpDelegate = delegate {
//                    icmpDelegate.icmpResultDelegate!(false, ipAddress: result.ipAddress.toString()!, roundTripTime: result.time, error: result.errorType?.description)
//                }
//            }
//            receiveBuffer.initialize(to: 0)
//        }
//        
//        close(socketfd)
//        receiveBuffer.deinitialize()
//        receiveBuffer.deallocate(capacity: recvPacketSize)
//    }
//    
//    static func xicmpScannerWithBroadcast(broadcastIpAddress: xIP, delegate: ResultDelegate, timeout: xTimeout? = 1000) {
//        xicmpScanner(broadcastIpAddress, timeout!, delegate, nil)
//    }
//    
//    static func xicmpScannerWithBroadcast(broadcastIpAddress: xIP, timeout: xTimeout? = 1000, block: @escaping icmpResultBlock) {
//        xicmpScanner(broadcastIpAddress, timeout!, nil, block)
//    }
//}
//
//// MARK: - Scanner Host by UDP
//extension ScannerHost {
//    
//}
