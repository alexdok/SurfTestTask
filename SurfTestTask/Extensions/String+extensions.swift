//
//  String+extensions.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 14.08.2023.
//

import UIKit

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
