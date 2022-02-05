//
//  BesselFunctions.swift
//  Errors_SphericalBesselFunctions
//
//  Created by Jasmine Panthee on 2/5/22.
//


import Foundation
import SwiftUI


/* Calculate Spherical Bessel functions using downward recursion */
/// calculateDownwardRecursion
/// - Parameters:
///   - xValue: x
///   - order: Order of Bessel Function
///   - start: Starting Order
///              2l+1
///     j       (x)  =   ------ j  (x)   -  j        (x)
///      l - 1              x       l             l + 1
///
///
func calculateDownwardRecursion (xValue: Double, order: Int, start: Int) -> Double
{
    var scale = calculateFirstBessel(xValue: xValue) /* jSub0 which we know. Used for scaling the downward recursion */
    
    var jSubl = Array(repeating: 0.0, count: start + 2) /* jSubl is an array that holds the various orders of the Bessel Function */
    
    
    jSubl[start+1] = 1.0                   // start with "guess"
    jSubl[start] = 1.0                      // start with "guess"
    
    for index in (1...start).reversed(){
        
        jSubl[index-1] = ((2.0*(Double(index))+1)/xValue)*jSubl[index] - jSubl[index+1]
    }
    
    scale = (scale)/jSubl[0];      /* scale the result */
    
    return(jSubl[order]*(scale))
}


/* Calculate Spherical Bessel functions using upward recursion */
/// calculateUpwardRecursion
/// - Parameters:
///   - xValue: x
///   - order: Order of Bessel Function
///               2l+1
///     j          (x)  =   ------  j  (x)  -  j       (x)
///       l + 1              x        l            l - 1
///
///
func calculateUpwardRecursion (xValue: Double, order: Int) -> Double
{
    var firstBessel = 0.0  /* temporary placeholders through the upward recursion */
    var secondBessel = 0.0 /* temporary placeholders through the upward recursion */
    var thirdBessel = 0.0; /* holds final Bessel Function result */
    
    
    firstBessel = calculateFirstBessel(xValue: xValue)                    /* start with lowest order */
    if (order == 0) {
        thirdBessel = firstBessel
    }
    else {
        
        secondBessel = calculateSecondBessel(xValue: xValue)
        for index in (1..<order)             /* loop for order of function */
        {
            thirdBessel = ((2.0*(Double(index))+1)/xValue)*secondBessel - firstBessel       // recursion relation
            firstBessel = secondBessel
            secondBessel = thirdBessel
        }
    }
    return(thirdBessel)
}



/// calculateFirstBessel
/// - Parameter xValue: x
/// - Returns: first Spherical Bessel Function
//  - j_0 : sin(x)/x
//
func calculateFirstBessel (xValue: Double) -> Double{
    
    let sum = sin(xValue)/xValue
    
    return sum
    
}


/// calculateSecondBessel
/// - Parameter xValue: x
/// - Returns: second Spherical Bessel Function
//    j_1(x) = sin(x)/x^2 - cos(x)/x
//
func calculateSecondBessel (xValue: Double) -> Double{
    
    let sum = sin(xValue)/(xValue↑2)-cos(xValue)
    
    return sum
    
 }
