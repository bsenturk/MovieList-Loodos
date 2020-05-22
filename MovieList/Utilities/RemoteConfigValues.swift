//
//  RemoteConfigValues.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

enum RemoteConfigValues: RawRepresentable {
    typealias RawValue = String

    case splashText

    var rawValue: RawValue {
        switch self {
        case .splashText:
            return "splash_text"
        }
    }

    init?(rawValue: String) {
        fatalError()
    }

    func getStringValue() -> String {
        RemoteConfig.remoteConfig().configValue(forKey: rawValue).stringValue ?? ""
    }

    func getIntValue() -> Int {
        RemoteConfig.remoteConfig().configValue(forKey: rawValue).numberValue?.intValue ?? 0
    }

    func getDoubleValue() -> Double {
        RemoteConfig.remoteConfig().configValue(forKey: rawValue).numberValue?.doubleValue ?? 0.0
    }

    func getBoolValue() -> Bool {
        RemoteConfig.remoteConfig().configValue(forKey: rawValue).boolValue
    }

}
