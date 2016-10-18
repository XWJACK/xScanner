//
//  Error.swift
//  xScanner
//
//  Created by Jack on 7/17/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

enum Result<Type> {
    case cussess(Type)
    case failure(Error)
}

protocol xScannerError: CustomDebugStringConvertible, CustomStringConvertible {

}

/// Scanner Error
enum ScannerError: CustomDebugStringConvertible, Error {
    case createSocketError
    case sendError
    case unpacketError
    case receiveError
    case connectError
    case unKnowError

    var debugDescription: String {
//        print(NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil))
        return result()
    }

    private func result() -> String {
        switch self {
        case .createSocketError:
            return ""
        default: return "unknow Error"
        }
    }
}
