//
//  AnalyticsEvent.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation
import FirebaseAnalytics

enum AnalyticsEvent: RawRepresentable {

    typealias RawValue = String

    case movieDetail(String, String, String)

    var rawValue: RawValue {
        switch self {
        case .movieDetail:
            return "movie_detail"
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .movieDetail(let title, let year, let description):
            return [
                "title": title,
                "year": year,
                "description": description
            ]
        }
    }

    init?(rawValue: String) {
        fatalError()
    }

    func sendEvent() {
        Analytics.logEvent(rawValue, parameters: parameters)
    }
}
