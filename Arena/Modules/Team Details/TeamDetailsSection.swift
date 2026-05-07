//
//  TeamDetailsSection.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation


enum TeamDetailsSection: Int, CaseIterable {
    case hero = 0
    case squad = 1
    
    var title: String? {
        switch self {
        case .hero: return nil
        case .squad: return "Squad"
        }
    }
}
