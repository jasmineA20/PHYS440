//
//  MonteCarlo_ex.swift
//  MonteCarlo_e-x_dx
//
//  Created by Jasmine Panthee on 2/10/22.
//

import Foundation
import SwiftUI

class MonteCarlo_ex: NSObject, ObservableObject {
    
    @MainActor @Published var insideData = [(xPoint: Double, yPoint: Double)]()
    @MainActor @Published var outsideData = [(xPoint: Double, yPoint: Double)]()
    @Published var totalGuessesString = ""
    @Published var guessesString = ""
    @Published var e_xAreaString = ""
    @Published var enableButton = true
    @Published var ExactIntegralString = ""
    @Published var errorString = ""
    @Published var ExactIntegral = 0.0
    @Published var Error = 0.0
    
    var e_xArea              = 0.0
    var guesses              = 1.0
    var totalGuesses         = 0.0
    var totalIntegral        = 0.0
    var y                    = 1.0
    var firstTimeThroughLoop = true
    var a                    = 0.0
    var b                    = 1.0
    
    
    
    @MainActor init(withData data: Bool){
        
        super.init()
        
        insideData = []
        outsideData = []
        
    }


    ///
    ///
    /// - Calculates the Value of area under  the curve e^x  using Monte Carlo Integration
    ///
    /// - Parameter sender: Any
    func calculateArea_e_x() async {
        
        var maxGuesses = 0.0
                
        let boundingBoxCalculator = BoundingBox() ///Instantiates Class needed to calculate the area of the bounding box.
                
                
        maxGuesses = Double(guesses)
                
        let newValue = await calculateMonteCarloIntegral(upper_limit: b, lower_limit: a, maxGuesses: maxGuesses)
        
        totalIntegral = totalIntegral + newValue
        totalGuesses = totalGuesses + guesses
                
        await updateTotalGuessesString(text: "\(totalGuesses)")
                
                
        e_xArea = totalIntegral/Double(totalGuesses) * boundingBoxCalculator.calculateSurfaceArea(numberOfSides: 2, lengthOfSide1: b, lengthOfSide2: b, lengthOfSide3: a)
        
    //    ExactIntegral = Exact_e_xdx(lowerlimit: a, upperlimit: b)
                
    //    Error = abs(ExactIntegral - e_xArea)
                    
        await update_e_xAreaString (text: "\(e_xArea)")
        
    //    errorString = "\(Error)"
    //    ExactIntegralString = "\(ExactIntegral)"
       
        
    }
//  This function returns the actual value of the integral e_x dx from 0 to 1
    //func Exact_e_xdx(lowerlimit: Double,  upperlimit: Double) -> Double{
    //    ExactIntegral = 0.0
    //    return ExactIntegral
    //}
    
    
    /// calculates the Monte Carlo Integral of a Circle
    ///
    /// - Parameters:
    ///   - radius: radius of circle
    ///   - upper_limit: upper limit of the integral
    ///   - lower_limit: lower limit of the integral
    ///   - maxGuesses: number of guesses to use in the calculaton
    /// - Returns: ratio of points inside to total guesses. Must mulitply by area of box in calling function
    func calculateMonteCarloIntegral(upper_limit: Double , lower_limit: Double, maxGuesses: Double) async -> Double {
        
        var numberOfGuesses = 0.0
        var pointsInRadius = 0.0
        var integral = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0)
        var yValue = 0.0 //value of y for a given x for the funnction
        
        var newInsidePoints : [(xPoint: Double, yPoint: Double)] = []
        var newOutsidePoints : [(xPoint: Double, yPoint: Double)] = []
        
        
        while numberOfGuesses < maxGuesses {
            
            /* Calculate 2 random values within the box */
            /* Determine the distance from that point to the origin */
            /* If the distance is less than the unit radius count the point being within the Unit Circle */
            point.xPoint = Double.random(in: -lower_limit...upper_limit)
            point.yPoint = Double.random(in: 0.0...1.0)
            
            yValue = exp(-point.xPoint)

            
            
            // if inside the area under the exponential function, add to the number of points in the radius
            if((yValue - point.yPoint) >= 0.0){
                pointsInRadius += 1.0
                
                newInsidePoints.append(point)
               
            }
            else { //if outside the area do not add to the number of points in the bounding box
                
                
                newOutsidePoints.append(point)

                
            }
            
            numberOfGuesses += 1.0
            
            
            
            
            }

        
        integral = Double(pointsInRadius)
        
        //Append the points to the arrays needed for the displays
        //Don't attempt to draw more than 250,000 points to keep the display updating speed reasonable.
        
        if ((totalGuesses < 500001) || (firstTimeThroughLoop)){
        
//            insideData.append(contentsOf: newInsidePoints)
//            outsideData.append(contentsOf: newOutsidePoints)
            
            var plotInsidePoints = newInsidePoints
            var plotOutsidePoints = newOutsidePoints
            
            if (newInsidePoints.count > 750001) {
                
                plotInsidePoints.removeSubrange(750001..<newInsidePoints.count)
            }
            
            if (newOutsidePoints.count > 750001){
                plotOutsidePoints.removeSubrange(750001..<newOutsidePoints.count)
                
            }
            
            await updateData(insidePoints: plotInsidePoints, outsidePoints: plotOutsidePoints)
            firstTimeThroughLoop = false
        }
        
        return integral
        }
    
    
    /// updateData
    /// The function runs on the main thread so it can update the GUI
    /// - Parameters:
    ///   - insidePoints: points inside the circle of the given radius
    ///   - outsidePoints: points outside the circle of the given radius
    @MainActor func updateData(insidePoints: [(xPoint: Double, yPoint: Double)] , outsidePoints: [(xPoint: Double, yPoint: Double)]){
        
        insideData.append(contentsOf: insidePoints)
        outsideData.append(contentsOf: outsidePoints)
    }
    
    /// updateTotalGuessesString
    /// The function runs on the main thread so it can update the GUI
    /// - Parameter text: contains the string containing the number of total guesses
    @MainActor func updateTotalGuessesString(text:String){
        
        self.totalGuessesString = text
        
    }
    
    /// updatePiString
    /// The function runs on the main thread so it can update the GUI
    /// - Parameter text: contains the string containing the current value of Pi
    @MainActor func update_e_xAreaString(text:String){
        
        self.e_xAreaString = text
        
    }

       
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    @MainActor func setButtonEnable(state: Bool){
        
        
        if state {
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
            
            
                
        }
        else{
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = false
                }
            }
                
        }
        
    }

}
