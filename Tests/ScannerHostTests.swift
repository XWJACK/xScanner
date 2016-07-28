//
//  ScannerHostTests.swift
//  xSocket
//
//  Created by Jack on 3/28/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import XCTest
@testable import xScanner


class ScannerHostTests: BaseTests, ResultDelegate {

    var scannerHost: ScannerHost!
    
    func testScannerHostWithBroadcastUseBlock() {
        ScannerHost.xicmpScannerWithBroadcast(broadcastIpAddress: broadcastAddress) { (isSuccess, ipAddress, roundTripTime, error) in
            if isSuccess {
                print("\(ipAddress) -- \(roundTripTime)")
            } else {
                print("\(ipAddress) -- \(error)")
            }
        }
    }

    func testScannerHostWithBroadcastUseDelegate() {
        ScannerHost.xicmpScannerWithBroadcast(broadcastIpAddress: broadcastAddress, delegate: self)
    }

    func testScannerHostWithAllHostUseBlock() {
        scannerHost = ScannerHost(ipAddress: locateAddresses)
        scannerHost.xicmpScannerWithAllHost { (isSuccess, ipAddress, roundTripTime, error) in
            if isSuccess {
                print("\(ipAddress) -- \(roundTripTime)")
            } else {
                print("\(ipAddress) -- \(error)")
            }
        }
    }

    func icmpResultDelegate(isSuccess: Bool, ipAddress: String, roundTripTime: Double, error: String?) {
        if isSuccess {
            print("\(ipAddress) -- \(roundTripTime)")
        } else {
            print("\(ipAddress) -- \(error)")
        }
    }
}
