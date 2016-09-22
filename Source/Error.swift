//
//  Error.swift
//  xScanner
//
//  Created by Jack on 7/17/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

protocol xScannerError: CustomDebugStringConvertible, CustomStringConvertible {

}

/// Common Error
enum CommonError: String, CustomDebugStringConvertible, CustomStringConvertible {
    case createSocketError
    case settingSocketError

    var debugDescription: String {
        print(NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil))
        return result()
    }

    var description: String {
        return result()
    }

    private func result() -> String {
        switch self {
        case .createSocketError:
            return CommonError.createSocketError.rawValue
        case .settingSocketError:
            return CommonError.settingSocketError.rawValue
        }
    }
}

/// ICMP Error
enum ICMPError: String, CustomDebugStringConvertible, CustomStringConvertible {
    case sendError
    case unPacketError
    case receiveError

    var debugDescription: String {
        print(NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil))
        return result()
    }

    var description: String {
        return result()
    }

    private func result() -> String {
        switch self {
        case .sendError:
            return ICMPError.sendError.rawValue
        case .unPacketError:
            return ICMPError.unPacketError.rawValue
        case .receiveError:
            return ICMPError.receiveError.rawValue
        }
    }
}

/// UDP Error
enum UDPError: String, CustomDebugStringConvertible, CustomStringConvertible {
    case sendError
    case receiveError

    var debugDescription: String {
        print(NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil))
        return result()
    }

    var description: String {
        return result()
    }

    private func result() -> String {
        switch self {
        case .sendError:
            return UDPError.sendError.rawValue
        case .receiveError:
            return UDPError.receiveError.rawValue
        }
    }
}

enum TCPError: String, CustomStringConvertible, CustomDebugStringConvertible {
    case connectError

    var debugDescription: String {
        print(NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil))
        return result()
    }

    var description: String {
        return result()
    }

    private func result() -> String {
        switch self {
        case .connectError:
            return TCPError.connectError.rawValue
        }
    }
}
