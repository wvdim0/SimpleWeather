//
//  UIDeviceExtension.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 27.07.2021.
//

import UIKit

public extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod9,1":                     return "iPod touch 7"
            case "iPhone8,4":                   return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":      return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":      return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":    return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":    return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":    return "iPhone X"
            case "iPhone11,2":                  return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":    return "iPhone XS Max"
            case "iPhone11,8":                  return "iPhone XR"
            case "iPhone12,1":                  return "iPhone 11"
            case "iPhone12,3":                  return "iPhone 11 Pro"
            case "iPhone12,5":                  return "iPhone 11 Pro Max"
            case "iPhone12,8":                  return "iPhone SE (2nd generation)"
            case "iPhone13,1":                  return "iPhone 12 mini"
            case "iPhone13,2":                  return "iPhone 12"
            case "iPhone13,3":                  return "iPhone 12 Pro"
            case "iPhone13,4":                  return "iPhone 12 Pro Max"
            case "i386", "x86_64":
                return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                            return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()
}
