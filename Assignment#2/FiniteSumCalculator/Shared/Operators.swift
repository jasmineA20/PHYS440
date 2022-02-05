//
//  Operators.swift
//  FiniteSumCalculator
//
//  Created by Jasmine Panthee on 2/5/22.
//

import SwiftUI
import Foundation

infix operator ↑: MultiplicationPrecedence
extension Double {
    static func ↑ (left: Double, right: Double) -> Double {
        return pow(left, right)
    }
}

