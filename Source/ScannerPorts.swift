//
//  ScannerPorts.swift
//  xScanner
//
//  Created by Jack on 4/1/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

class ScannerPorts {
    private var ipAddress: xIP
    
//    init?(ipAddress: String) {
//        self.ipAddress = inet_addr(ipAddress)
//        guard self.ipAddress != INADDR_NONE else { return nil }
//    }
    init(ipAddress: xIP) {
        self.ipAddress = ipAddress
    }
    
    func xScannerPortsWithUDP() {
        
    }
    
    deinit {
        print("destory")
    }
}

extension ScannerPorts {
    
    static func xScannerPortsWithTCP(ipAddress: xIP) -> [xPort] {
        
        var portOpen: [xPort] = []
        
//        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        let group = dispatch_group_create()
//        let currentSemphore = dispatch_semaphore_create(50)
//        
//        for port in 0...65535 {
//            dispatch_semaphore_wait(currentSemphore, DISPATCH_TIME_FOREVER)
//            dispatch_group_async(group, queue, {
//                if xConnectWithTCP(ipAddress, UInt16(port)) == true { portOpen.append(UInt16(port)) }
//                dispatch_semaphore_signal(currentSemphore)
//            })
//        }
//        
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        
        return portOpen
    }
}