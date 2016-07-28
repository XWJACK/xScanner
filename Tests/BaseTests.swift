//
//  BaseTests.swift
//  xScanner
//
//  Created by Jack on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class BaseTests: XCTestCase {

    var locateEthernetInformation: [xIP] = []
    var locateAddresses: [xIP] = []

    var currentEthernetName: String?
    var locateAddress: xIP { return locateEthernetInformation[0] }
    var netmaskAddress: xIP { return locateEthernetInformation[1] }
    var broadcastAddress: xIP { return locateEthernetInformation[2] }

    let pid = xGetPid()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let locateInformation = getInterfaceInformationWithInt()

        #if TARGET_IPHONE_SIMULATOR
            if let temp = locateInformation["en0"] {
                locateEthernetInformation = temp
                currentEthernetName = "en0"
            } else if let temp = locateInformation["pdp_ip0"] {
                locateEthernetInformation = temp
                currentEthernetName = "pdp_ip0"
            } else {
                assertionFailure("InterfaceError")
                currentEthernetName = nil
            }
            #else
            if let temp = locateInformation["en1"] {
                locateEthernetInformation = temp
                currentEthernetName = "en1"
            } else {
                assertionFailure("InterfaceError")
                currentEthernetName = nil
            }
        #endif
        let calculate = Calculate(ipAddress: locateEthernetInformation[0], netmask: locateEthernetInformation[1])
        locateAddresses = calculate.allHostsIPWithInt
        print("All: \(getInterfaceInformationWithString())")
        print("Locate Address: \(locateAddress.toString()!)")
        print("Netmask Address: \(netmaskAddress.toString()!)")
        print("Broadcast Address: \(broadcastAddress.toString()!)")
    }
}

// MARK: - ICMP Result Tests
extension BaseTests {
    
    func icmpResultTest(icmpresult: icmpReuslt) -> String {
        if icmpresult.isSuccess {
            return icmpresult.ipAddress.toString()! + " -- " + icmpresult.time.description
        } else {
            return icmpresult.ipAddress.toString()! + " -- " + icmpresult.errorType!.description
        }
    }
}
