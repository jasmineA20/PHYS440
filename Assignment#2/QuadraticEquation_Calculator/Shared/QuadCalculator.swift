//
//  QuadCalculator.swift
//  QuadraticEquation_Calculator
//
//  Created by Jasmine Panthee on 2/5/22.
//
//
import SwiftUI
import Foundation
class QuadraticEquation: NSObject, ObservableObject{
    @Published var a = 0.0
    @Published var b = 0.0
    @Published var c = 0.0
    @Published var x_minus = 0.0
    @Published var x_plus = 0.0
    @Published var xp_minus = 0.0
    @Published var xp_plus = 0.0
    
//                           ________________
//                        | / 2
//               - b  pm  |/ b   -  4 * a * c
//x            =   -----------------------------
//plus,minus                   2a

    func x_minusCalculator(a:Double, b:Double, c:Double) -> Double{
        x_minus = (-b - sqrt(pow(b,2.0) - 4.0*a*c))/(2.0*a)
        return (x_minus)
    }
    
    func x_plusCalculator(a:Double, b:Double, c:Double) -> Double{
        x_plus = (-b + sqrt(pow(b,2.0) - 4.0*a*c))/(2.0*a)
        return (x_plus)
    }
//                             - 2c
//    x'            =   --------------------------
//    plus,minus                 ________________
//                            | / 2
//                     b  pm  |/ b   -  4 * a * c
//
    
    func xp_minusCalculator(a:Double, b:Double, c:Double) -> Double{
        xp_minus = (-2.0*c)/(b - sqrt(pow(b,2.0) - 4*a*c))
        return (xp_minus)
    }
    
    func xp_plusCalculator(a:Double, b:Double, c:Double) -> Double{
        xp_plus = (-2.0*c)/(b - sqrt(pow(b,2.0) - 4*a*c))
        return (xp_plus)
    }
}
