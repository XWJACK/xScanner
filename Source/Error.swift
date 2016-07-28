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
        case createSocketError:
            return createSocketError.rawValue
        case settingSocketError:
            return settingSocketError.rawValue
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
        case sendError:
            return sendError.rawValue
        case unPacketError:
            return unPacketError.rawValue
        case .receiveError:
            return receiveError.rawValue
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
        case sendError:
            return sendError.rawValue
        case .receiveError:
            return receiveError.rawValue
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
        case connectError:
            return connectError.rawValue
        }
    }
}
