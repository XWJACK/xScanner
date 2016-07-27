//
//  Result.swift
//  xScanner
//
//  Created by Jack on 7/26/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import Foundation

@objc public protocol ResultDelegate {
    optional func icmpResultDelegate(isSuccess: Bool, ipAddress: String, roundTripTime: Double, error: String?)
}

public typealias icmpResultBlock = (isSuccess: Bool, ipAddress: String, roundTripTime: Double, error: String?) -> ()