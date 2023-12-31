//
//  CustomeButton.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 12.09.2023.
//


import UIKit

class CustomeButton: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -30, dy: -30).contains(point)
    }
}
