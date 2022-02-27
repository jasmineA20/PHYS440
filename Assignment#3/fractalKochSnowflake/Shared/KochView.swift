//
//  KochView.swift
//  fractalKochSnowflake
//
//  Created by Jasmine Panthee on 2/11/22.
//

import Foundation
import SwiftUI

struct KochView: View {
    
    @Binding var iterationsFromParent: Int?
    @Binding var angleFromParent: Int?
    
    /// Class Parameters Necessary for Drawing
    var allThePoints: [(xPoint: Double, yPoint: Double, radiusPoint: Double, color: String)] = []  ///Array of tuples
    var x: CGFloat = 75
    var y: CGFloat = 100
    let pi = CGFloat(Float.pi)
    var piDivisorForAngle = 0.0
    
    var angle: CGFloat = 0.0


    
    var body: some View {
        
        //Create the displayed View from the function
        createCesaroFractalShapeView(iterations: iterationsFromParent, piAngleDivisor: angleFromParent)
                .padding()

    }
    
    /// createCesaroFractalShapeView
    ///
    /// This function ensures that the program will not crash if non-valid input is accidentally entered by the user.
    ///
    /// - Parameters:
    ///   - iterations: number of iterations in the fractal
    ///   - piAngleDivisor: integer that sets the angle as pi/piAngleDivisor so if 2, then the angle is π/2
    /// - Returns: View With Cesaro Fractal Shape
    func createCesaroFractalShapeView(iterations: Int?, piAngleDivisor: Int?) -> some View {
        
            var newIterations :Int? = 0
            var newPiAngleDivisor :Int? = 2
        
        // Test to make sure the input is valid
            if (iterations != nil) && (piAngleDivisor != nil) {
                
                    
                    newIterations = iterations
                    
                    newPiAngleDivisor = piAngleDivisor

                
            } else {
                
                    newIterations = 0
                    newPiAngleDivisor = 2
               
                
            }
        
        //Return the view with input numbers. View is blank if values are bad.
            return AnyView(
                KochFractalShape(iterations: newIterations!, piAngleDivisor: newPiAngleDivisor!)
                    .stroke(Color.red, lineWidth: 1)
                    .frame(width: 600, height: 600)
                    .background(Color.white)
                )
        }
    
}

/// CesaroFractalShape
///
/// calculates the Shape displayed in the Cesaro Fractal View
///
/// - Parameters:
///   - iterations: number of iterations in the fractal
///   - piAngleDivisor: integer that sets the angle as pi/piAngleDivisor so if 2, then the angle is π/2
struct KochFractalShape: Shape {
    
    let iterations: Int
    let piAngleDivisor: Int
    let smoothness : CGFloat = 1.0
    
    
    func path(in rect: CGRect) -> Path {
        
        var KochPoints: [(xPoint: Double, yPoint: Double)] = []  ///Array of tuples
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        let size: Double = 476
        
        // draw from the center of our rectangle
        //let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        // Offset from center in y-direction for Cesaro Fractal
        let yoffset = (rect.height-size)/2 + 11.6
        
//        x = center.x - CGFloat(size/2.0)
//        y = rect.height/2.0 - CGFloat(yoffset)
         x = rect.width/2
        y = rect.height - (rect.height-size)/2 + yoffset/2
        
        
        guard iterations >= 0 else { return Path() }
        
        guard iterations <= 7 else { return Path() }
        
        guard piAngleDivisor > 0 else {return Path()}
        
        guard piAngleDivisor <= 50 else {return Path()}
    
        KochPoints = KochFractalCalculator(fractalnum: iterations, x: x, y: y, size: size, angleDivisor: piAngleDivisor)
        

        // Create the Path for the Cesaro Fractal
        
        var path = Path()

        // move to the initial position
        path.move(to: CGPoint(x: KochPoints[0].xPoint, y: KochPoints[0].yPoint))

        // loop over all our points to draw create the paths
        for item in 1..<(KochPoints.endIndex)  {
        
            path.addLine(to: CGPoint(x: KochPoints[item].xPoint, y: KochPoints[item].yPoint))
            
            
            }


        return (path)
    }
}





struct CesaroView_Previews: PreviewProvider {
    
    @State static var iterations :Int? = 2
    @State static var angle :Int? = 3
    
    static var previews: some View {
    

        KochView(iterationsFromParent: $iterations, angleFromParent: $angle)
        
    }
}
