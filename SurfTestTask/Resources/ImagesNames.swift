//
//  ImagesNames.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 14.08.2023.
//

import Foundation

enum ImagesNames {
    case okButton
    case pan
    case photo
    case pin
    case del
    
    var name: String {
        switch self {
        case .okButton:
            return "OkButton"
        case .pan:
            return "Pan"
        case .photo:
            return "photo"
        case .pin:
            return "Pin"
        case .del:
            return "X"
        }
    }
}
