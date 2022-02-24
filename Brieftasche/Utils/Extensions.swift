//
//  Extensions.swift
//  Brieftasche
//
//  Created by Lloyd on 2/24/22.
//

import Foundation

extension String {
    func withCommas() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num = Double(self)!
        return formatter.string(from: NSNumber(value: num))!
    }
}
