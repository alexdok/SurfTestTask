//
//  Fonts.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 14.08.2023.
//

import Foundation

enum Fonts: String {
    case appleSDGothicNeo
    case sFProDisplayBold
    case sFProDisplayRegular
    case sFProDisplayMedium
    
    var name:String {
        switch self {
        case .appleSDGothicNeo:
            return "AppleSDGothicNeo-Regular"
        case .sFProDisplayBold:
            return "SFProDisplay-Bold"
        case .sFProDisplayRegular:
            return "SFProDisplay-Regular"
        case .sFProDisplayMedium:
            return "SFProDisplay-Medium"
        }
    }
}
