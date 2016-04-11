//
//  xScanner.swift
//  xScanner
//
//  Created by 许文杰 on 4/2/16.
//  Copyright © 2016 许文杰. All rights reserved.
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