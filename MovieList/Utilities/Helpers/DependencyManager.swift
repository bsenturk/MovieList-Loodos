//
//  DependencyManager.swift
//  MovieList
//
//  Created by Burak Şentürk on 22.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Firebase

final class DependencyManager {

    static func configure() {
        configureFirebase()
    }

    private static func configureFirebase() {
        FirebaseApp.configure()
        RemoteConfigManager.shared.fetchRemoteConfig()
    }
}
