//
//  Sport.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import Foundation

enum Sport: String, CaseIterable {
    case football = "football"
    case basketball = "basketball"
    case tennis = "tennis"
    case cricket = "cricket"

    var imageName: String {
        switch self {
        case .football: return "bg_soccer"
        case .basketball: return "bg_basketball"
        case .tennis: return "bg_tennis"
        case .cricket: return "bg_cricket"
        }
    }
}
