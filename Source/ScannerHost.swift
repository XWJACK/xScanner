//
//  Scanner.swift
//  xSocket
//
//  Created by XWJACK on 3/20/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation


public class ScannerHost {
    
    private var xIpAddress = [in_addr_t]()
    weak var delegate:ResultDelegate?
    
    public var ipAddress:[String] {
        //let queue = dispatch_queue_create("com.xwjack.scannerhost.ipaddress", DISPATCH_QUEUE_SERIAL)
        //dispatch_sync(queue, {
            get {
                var temp = [String]()
                for i in xIpAddress { temp.append(String.fromCString(inet_ntoa(in_addr(s_addr: i)))!) }
                return temp
            }
            set {
                for var i = 0; i < newValue.count; i++ { xIpAddress[i] = inet_addr(newValue[i]) }
            }
        //})
    }
    
    init(ipAddress:[in_addr_t], delegate:ResultDelegate?) {
        self.xIpAddress = ipAddress
        self.delegate = delegate
    }
    
    private static func xicmpScanner(broadcastIpAddress:in_addr_t, _ timeout:Int32, _ delegate:ResultDelegate?, _ block:icmpResultBlock?) {
        
        var socketfd:Int32 = 0
        let pid = UInt16(getpid())
        
        guard xPingPrepare(&socketfd, pid, broadcastIpAddress, 0, timeout) != false else { return }
        
        let receiveBuffer = UnsafeMutablePointer<Int8>.alloc(84)
        let group = dispatch_group_create()
        while true {
            guard recvfrom(socketfd, receiveBuffer, 84, 0, nil, nil) != -1 else { break }
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                let result = xUnicmpPacket(receiveBuffer, pid, 0, 84)
                if result.0 != false {
                    if let icmpBlock = block {
                        icmpBlock(String.fromCString(inet_ntoa(in_addr(s_addr: result.1)))!, result.2)
                    }
                    if let icmpDelegate = delegate {
                        icmpDelegate.icmpResultDelegate!(String.fromCString(inet_ntoa(in_addr(s_addr: result.1)))!, result.2)
                    }
                }else { print("error") }
            })
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        close(socketfd)
        receiveBuffer.dealloc(84)
    }
    
    public static func xicmpScannerWithBroadcast(broadcastIpAddress:in_addr_t, delegate:ResultDelegate, timeout:Int32? = 2000) {
        xicmpScanner(broadcastIpAddress, timeout!, delegate, nil)
    }
    
    public static func xicmpScannerWithBroadcast(broadcastIpAddress:in_addr_t, timeout:Int32? = 2000, block:icmpResultBlock) {
        xicmpScanner(broadcastIpAddress, timeout!, nil, block)
    }
    
    
    public func xicmpScannerWithAllHost(timeout:Int32? = 5000, block:icmpResultBlock) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        //let semaphore = dispatch_semaphore_create(20)
        
        var socketfd:Int32 = 0
        let pid = UInt16(getpid())
        guard xPingSetting(&socketfd, timeout!) == true else { return }
        
        for ipAddr in xIpAddress {
            //dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            dispatch_async(queue, {
                
                xPingSend(socketfd, pid, ipAddr, 0)
                
                //dispatch_semaphore_signal(semaphore)
            })
        }
        
        let receiveBuffer = UnsafeMutablePointer<Int8>.alloc(84)
        receiveBuffer.initialize(0)
        while true {
            guard xPingReceive(socketfd, receiveBuffer) == true else { break }
            let result = xUnicmpPacket(receiveBuffer, pid, 0, 84)
            if result.0 != false {
                block(String.fromCString(inet_ntoa(in_addr(s_addr: result.1)))!, result.2)
                //print("\(String.fromCString(inet_ntoa(in_addr(s_addr: result.1)))!):\(result.2)")
            }
        }
        close(socketfd)
        receiveBuffer.destroy()
        receiveBuffer.dealloc(84)
    }
}
