//
//  Constants.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 05/03/24.
//

import Foundation

enum ProfileImageSize {
    case xxSmall
    case xSmal
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmal: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        case .xxLarge: return 120
        }
    }
}
