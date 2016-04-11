//
//  xScanner.swift
//  xScanner
//
//  Created by XWJACK on 4/2/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation


@objc public protocol ResultDelegate {
    optional func icmpResultDelegate(ipAddress:String, _ roundTripTime:Double)
}

public typealias icmpResultBlock = (String, Double) -> Void


extension String {
    func ping(number:Int) -> Double {
        return NetworkLatency.ping(self, number: number)
    }
}