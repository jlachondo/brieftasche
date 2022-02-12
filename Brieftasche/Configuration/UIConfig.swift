//
//  UIConfig.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI
import UIKit

class UIConfig {
    // Fonts
    static let brandFont = Font.custom("ShortStack", size: 28)
    static let xSmallFont = Font.custom("Itim", size: 14)
    static let smallFont = Font.custom("Itim", size: 18)
    static let regularFont = Font.custom("Itim", size: 21)
    static let mediumFont = Font.custom("Itim", size: 28)
    static let largeFont = Font.custom("Itim", size: 36)
    static let xLargeFont = Font.custom("Itim", size: 42)
    
    // Color
    static let primaryBgColor: UIColor = .white
    static let secondaryBgColor = UIColor(red: 0.31, green: 0.74, blue: 0.73, alpha: 1.00)
    static let primaryFontColor = Color(red: 0.03, green: 0.13, blue: 0.15)
    static let secondaryFontColor: Color = .white
    static let tertiaryFontColor = Color(red: 0.21, green: 0.52, blue: 0.55)
    static let primaryBtnBGColor = Color(red: 0.21, green: 0.52, blue: 0.55)
    static let secondaryBtnBGColor = Color(red: 0.94, green: 0.94, blue: 0.94)
    static let secondaryBtnBGMaterial: Material = .thinMaterial
    static let errorMsgBgColor = Color(red: 0.87, green: 0.29, blue: 0.28)
    static let unselectedTabBGColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.00)
}
