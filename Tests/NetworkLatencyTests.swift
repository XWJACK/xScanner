//
//  NetworkLatencyTests.swift
//  xScanner
//
//  Created by Jack on 4/10/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner

class NetworkLatencyTests: BaseTests {

    func testNetworkLatency() {
        print(NetworkLatency.ping(locateAddresses[0], number: 10))
    }
}
