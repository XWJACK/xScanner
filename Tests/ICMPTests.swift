//
//  ICMPTests.swift
//  xScanner
//
//  Created by XWJACK on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class ICMPTests: BaseTests {

    func testPing() {
        for ipAddress in locateAddresses {
            print(icmpResultTest(xPing(ipAddress, 0, 1000)))
        }
    }

    // send icmp packet but not receive
    func testxPingPrepare() {
        var socketfd: xSocket = 0
        for (sequence, ipaddress) in locateAddresses.enumerate() {
            xPingPrepare(&socketfd, pid, ipaddress, UInt16(sequence).bigEndian, 3000)
        }
    }

    // same as testxPingPrepare
    func testPingSend() {
        var socketfd: xSocket = 0
        xPingSetting(&socketfd, 1000)
        for (sequence, ipaddress) in locateAddresses.enumerate() {
            xPingSend(socketfd, pid, ipaddress, UInt16(sequence).bigEndian)
        }
    }
}
