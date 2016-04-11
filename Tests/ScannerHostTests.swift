//
//  ScannerHostTests.swift
//  xSocket
//
//  Created by 许文杰 on 3/28/16.
//  Copyright © 2016 许文杰. All rights reserved.
//

import XCTest
@testable import xScanner


class ScannerHostTests: BaseTests, ResultDelegate {
    

    func testScannerHostWithBroadcastUseBlock() {
        ScannerHost.xicmpScannerWithBroadcast(self.locateEthernetInformation[2]) { (ipAddress, rtt) -> Void in
            print("Block: \(ipAddress): \(rtt)")
        }
    }
    
//    func testScannerHostWithBroadcastUseDelegate() {
//        ScannerHost.xicmpScannerWithBroadcast(self.locateEthernetInformation[2], delegate: self)
//    }
    
    func testScannerHostWithAllHostUseBlock() {
        let scannerhost = ScannerHost(ipAddress: locateAddress, delegate: nil)
        scannerhost.xicmpScannerWithAllHost { (ipAddress, rtt) -> Void in
            print("Block: \(ipAddress): \(rtt)")
        }
    }
    
//    func xicmpScannerResult(ipAddress: String, _ rtt: Double) {
//        print("Delegate: \(ipAddress): \(rtt)")
//    }
}
