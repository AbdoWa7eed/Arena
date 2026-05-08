//
//  Sport.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import Foundation

enum Sport: CaseIterable {
    case football
    case basketball
    case tennis
    case cricket
    
    var name: String {
        switch self {
        case .football: return "Football"
        case .basketball: return "Basketball"
        case .tennis: return "Tennis"
        case .cricket: return "Cricket"
        }
    }
    
    var imageName: String {
        switch self {
        case .football: return "bg_soccer"
        case .basketball: return "bg_basketball"
        case .tennis: return "bg_tennis"
        case .cricket: return "bg_cricket"
        }
    }
}
