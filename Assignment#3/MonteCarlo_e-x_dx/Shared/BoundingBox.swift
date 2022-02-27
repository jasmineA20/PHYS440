//
//  BoundingBox.swift
//  MonteCarlo_e-x_dx
//
//  Created by Jasmine Panthee on 2/4/22.
//

import Foundation
import SwiftUI

class BoundingBox: NSObject {
    
    
    func calculateMean(lengthOfSide1:Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        
        
        return (lengthOfSide1*lengthOfSide2*lengthOfSide3)
        
    }
    

    func calculateSurfaceArea( numberOfSides: Double, lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        
        var surfaceArea = 0.0
        
        if numberOfSides == 2 {
                   
                   surfaceArea = lengthOfSide1*lengthOfSide2
                   
               } else if numberOfSides == 6 {
                   
                   surfaceArea = 2*lengthOfSide1*lengthOfSide2 + 2*lengthOfSide2*lengthOfSide3 + 2*lengthOfSide1*lengthOfSide3
                   
                   
               } else {
                   
                   surfaceArea = 0.0
                   
               }
               
               return (surfaceArea)
    }

}
