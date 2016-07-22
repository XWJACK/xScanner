//
//  Calculate.swift
//  xSocket
//
//  Created by XWJACK on 3/21/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

/// Calculate Network Information about all the possible IP address.....
class Calculate {
    
    private var mask: xIP
    private var ip: xIP
    
    init(ipAddress: xIP, netmask: xIP) {
        self.ip = ipAddress
        self.mask = netmask
    }
    
    /// calculate host number in lan(contain 0 and 255)
    var HostsNumber: Int { return Int(~mask.bigEndian) + 1 }
    
    /// calculate first ip address
    var firstIPAddress: xIP { return ip & mask }
    
    var allHostsIPWithInt: [xIP] {
        var tempIP: [xIP] = []
        tempIP.reserveCapacity(HostsNumber - 2)
        
        for i in 0..<HostsNumber - 2 {
            tempIP.append(CFSwapInt32(CFSwapInt32(firstIPAddress) + UInt32(i + 1)))
        }
        return tempIP
    }
}

// MARK: - To String
extension Calculate {
//    /**
//     if ip or netmask is error,return nil
//     
//     - parameter ipAddress: ip
//     - parameter netmask:   mask
//     
//     - returns: return nil if error
//     */
//    init?(ipAddress: String, netmask: String) {
//        ip = inet_addr(ipAddress)
//        mask = inet_addr(netmask)
//        
//        if ip == INADDR_NONE { return nil }
//        if mask == INADDR_NONE { return nil }
//    }
//    
//    /// calculate first ip address like 192.168.1.0
//    var firstIPAddress: String { return (ip & mask).toString()! }
//    
//    /// calculate all host ip address like 192.168.1.1~192.168.1.254
//    var allHostIPWithString: [String] {
//        var temp = [String]()
//        for i in 0..<HostsNumber - 2 {
//            let tempip = CFSwapInt32(CFSwapInt32(inet_addr(firstIPAddress)) + UInt32(i + 1))
//            temp.append(tempip.toString()!)
//        }
//        return temp
//    }
}