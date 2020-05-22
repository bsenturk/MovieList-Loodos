//
//  RemoteConfigManager.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import FirebaseRemoteConfig

final class RemoteConfigManager {
    static let shared = RemoteConfigManager()

    func fetchRemoteConfig() {
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = remoteConfigSettings
        RemoteConfig.remoteConfig().setDefaults(fromPlist: "RemoteConfigDefaultValues")

        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { status, error in

            if let error = error {
                print(error.localizedDescription)
            } else {
                switch status {
                case .success:
                    print("sucess")
                case .failure:
                    print("failed")
                default:
                    break
                }
            }
        }
    }
}

