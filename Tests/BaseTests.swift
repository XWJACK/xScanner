//
//  BaseTests.swift
//  xScanner
//
//  Created by 许文杰 on 4/10/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import XCTest
@testable import xScanner

class BaseTests: XCTestCase {
    var locateEthernetInformation = [in_addr_t]()
    var locateAddress = [in_addr_t]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let locateInformation = getInterfaceInformationWithInt()
        
        #if TARGET_IPHONE_SIMULATOR
            if let temp = locateInformation["en0"] {
                locateEthernetInformation = temp
            }else if let temp = locateInformation["pdp_ip0"] {
                locateEthernetInformation = temp
            }else {
                assert(false, "InterfaceError")
            }
            #else
            if let temp = locateInformation["en1"] {
                locateEthernetInformation = temp
            }else {
                assert(false, "InterfaceError")
            }
        #endif
        let calculate = Calculate(ipAddress: locateEthernetInformation[0], netmask: locateEthernetInformation[1])
        locateAddress = calculate.allHostIPWithInt
    }
}
