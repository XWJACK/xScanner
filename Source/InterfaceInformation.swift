//
//  InterfaceInformation.swift
//  xSocket
//
//  Created by Jack on 3/21/16.
//  Copyright © 2016 XWJACK. All rights reserved.
//

import NetworkExtension
import SystemConfiguration.CaptiveNetwork

func getInterfaceInformationWithString() -> [String: [String]] {
    var information: [String: [String]] = [:]
    
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    //retrieve the current interface -- return 0 on success
    guard getifaddrs(&ifaddr) == 0 else { return information }
    
    var interface = ifaddr
    //loop through linked list of interface
    while interface != nil {
        if interface?.pointee.ifa_addr.pointee.sa_family == UInt8(AF_INET) {//ipv4
            let interfaceName = String.fromCString(interface!.pointee.ifa_name)
            let interfaceAddress = String.fromCString(inet_ntoa(UnsafeMutablePointer<sockaddr_in>(interface.pointee.ifa_addr).pointee.sin_addr))
            let interfaceNetmask = String.fromCString(inet_ntoa(UnsafeMutablePointer<sockaddr_in>(interface.pointee.ifa_netmask).pointee.sin_addr))
            //ifa_dstaddr /* P2P interface destination */
            //The ifa_dstaddr field references the destination address on a P2P inter-face, interface,
            //face, if one exists, otherwise it contains the broadcast address.
            let interfaceBroadcast = String.fromCString(inet_ntoa(UnsafeMutablePointer<sockaddr_in>(interface.pointee.ifa_dstaddr).pointee.sin_addr))
            
            if let name = interfaceName {
                information[name] = [interfaceAddress!,interfaceNetmask!,interfaceBroadcast!]
            }
        }
        interface = interface.pointee.ifa_next
    }
    freeifaddrs(ifaddr)
    
    return information
}


func getInterfaceInformationWithInt() -> [String: [xIP]] {
    var information: [String: [xIP]] = [:]
    
    var ifaddr:UnsafeMutablePointer<ifaddrs> = nil
    //retrieve the current interface -- return 0 on success
    guard getifaddrs(&ifaddr) == 0 else { return information }
    
    var interface = ifaddr
    //loop through linked list of interface
    while interface != nil {
        if interface.pointee.ifa_addr.pointee.sa_family == UInt8(AF_INET) {//ipv4
            let interfaceName = String.fromCString(interface.pointee.ifa_name)
            let interfaceAddress = UnsafeMutablePointer<sockaddr_in>(interface.pointee.ifa_addr).pointee.sin_addr.s_addr
            let interfaceNetmask = UnsafeMutablePointer<sockaddr_in>(interface.pointee.ifa_netmask).pointee.sin_addr.s_addr
            //ifa_dstaddr /* P2P interface destination */
            //The ifa_dstaddr field references the destination address on a P2P inter-face, interface,
            //face, if one exists, otherwise it contains the broadcast address.
            let interfaceBroadcast = UnsafeMutablePointer<sockaddr_in>(interface.pointee.ifa_dstaddr).pointee.sin_addr.s_addr
            
            if let name = interfaceName {
                information[name] = [interfaceAddress,interfaceNetmask,interfaceBroadcast]
            }
        }
        interface = interface.pointee.ifa_next
    }
    freeifaddrs(ifaddr)
    
    return information
}


func getNetworkEnvironment() -> [String: String]? {
    var informationDictionary: [String: String] = [:]
    if #available(iOS 9.0, *) {
        let information = NEHotspotHelper.supportedNetworkInterfaces()
        if information.isEmpty { return nil }
        informationDictionary["SSID"] = information[0].SSID ?? "Unknow"
        informationDictionary["BSSID"] = information[0].BSSID ?? "Unknow"
        return informationDictionary
    } else {
        // Fallback on earlier versions
        let informationArray: NSArray? = CNCopySupportedInterfaces()
        if let information = informationArray,
            let dict: NSDictionary = CNCopyCurrentNetworkInfo(information[0] as! CFStringRef) {
            
            informationDictionary["SSID"] = dict["SSID"] as? String ?? "Unknow"
            informationDictionary["BSSID"] = dict["BSSID"] as? String ?? "Unknow"
            return informationDictionary
        }
    }
    return informationDictionary
}
