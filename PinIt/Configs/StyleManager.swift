//
//  StyleManager.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/21.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import Foundation
import ChameleonFramework

typealias Style = StyleManager

final class StyleManager {
    
    static func setUpTheme() {
        Chameleon.setGlobalThemeUsingPrimaryColor(primaryTheme(), withSecondaryColor: theme(), usingFontName: font(), andContentStyle: content())
    }
    
    // MARK: - Theme
    
    static func primaryTheme() -> UIColor {
        return UIColor(red:0.00, green:0.44, blue:0.59, alpha:1.0)
    }
    
    static func fontColor() -> UIColor {
        return FlatWhite()
    }
    
    static func borderColor() -> UIColor {
        return FlatGray()
    }
    
    static func theme() -> UIColor {
        return FlatPlum()
    }
    
    static func toolBarTheme() -> UIColor {
        return FlatBlue()
    }
    
    static func content() -> UIContentStyle {
        return UIContentStyle.contrast
    }
    
    static func font() -> String {
        return UIFont(name: FontType.Primary.fontName, size: FontType.Primary.fontSize)!.fontName
    }
    
    
}

enum FontType {
    case Primary
}

extension FontType {
    var fontName: String {
        switch self {
        case .Primary:
            return "HelveticaNeue"
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .Primary:
            return 16.0
        }
    }
}
