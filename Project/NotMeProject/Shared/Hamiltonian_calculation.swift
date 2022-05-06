//
//  Hamiltonian_calculation.swift
//  NotMeProject
//
//  Created by Jasmine Panthee on 5/1/22.
//

import Foundation
import SwiftUI
import Accelerate
import CorePlot
import ComplexModule
import Numerics


class BandStructures: NSObject,ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    var PotentialData: Potential? = nil
    var kData: WaveVector? = nil
    @Published var a = 5.43
    @Published var tau:[Double] = []
    @Published var negTau:[Double] = []
    @Published var G:[Double] = []
    @Published var stepSize = 0.01
    let hbarsquareoverm = 7.62 // units of eV A^2
    var H:[Complex<Double>] = []
    var u = 0.0
    var v = 0.0
    var w = 0.0
    var rydberg = 13.6056980659
    
    var V3S = 0.0
    var V8S = 0.0
    var V11S = 0.0
    var V3A = 0.0
    var V4A = 0.0
    var V11A = 0.0
    var VS = 0.0 //symmetric
    var VA = 0.0 //antisymmetric
    
    @Published var selectedBand = ""
    @Published var V = Complex<Double>(0, 0)
    
    
    
    
    
    
//pseudopotential Hailtonian
//
//              2         2
//  H  =   - ( ℏ  / 2m) ∇   +  V(r)
//pseudopotential symmetric and anti-symmetric form
//
//              s      s        A    A   - iG * r
//V(r)  =  Σ ( S  (G) V   +  i S (G)V ) e
//                      G            G
    override init() {
        
        super.init()
        let fcc:[Double] = [0.125, 0.125, 0.125]
        
        let r1 = fcc.map { $0 * self.a }
        
        let r2 = r1.map { $0 * -1 }
       
        tau = r1
        negTau = r2
        
    }
    
    
    func makeG(selectedBand: String) {
    
    //Reciprocal Lattice Vector G
    //G^2 only has non-zero potential at 3, 4, 8, 11
    //G = b1*u + b2*v + b3*w  with u, v, w in range -2, -1, 0, 1, 2
    //creates a 125x125 matrix
    //states = 5 --> {-2, -1, 0, 1, 2}
    
        let b1:[Double] = [-1, 1, 1]
     
        let b2:[Double] = [1, -1, 1]
    
        let b3 :[Double] = [1, 1, -1]
    //How to go through all u, v, w values to get G for matrix?
        let states = 5
    //m is an increment that goes over all possible values of u, v, and w
       
        
        for m in stride(from: -62.0, through: 62.0, by: 1.0) {
            
        var G:[Double] = [] //Reset G through each m iteration after calling on V and appending to H
        let s = Double(states)
        let n = pow(s, 3.0) - 1.0
        let nHalf = n/2.0
        let mN = m + nHalf
        let flr = floor(s/2.0)
        let statesSqrd = pow(s, 2.0)
        
        u = floor(mN/statesSqrd) - flr
        
        v = floor((mN).truncatingRemainder(dividingBy: statesSqrd)/s) - flr
        w = (mN).truncatingRemainder(dividingBy: s) - flr
       // w = s%(Double(states) - flr)
            let first = b1.map { $0 * u }
            let second = b2.map { $0 * v }
            let third = b3.map { $0 * w }
            let b12 = zip(first, second).map { $0 + $1 }
            let bValues = zip(b12, third).map { $0 + $1 }
        G.append(bValues[0])
        G.append(bValues[1])
        G.append(bValues[2])
            
    
            let GSquared = zip(G, G).map { $0 * $1 }
            
            let GG = GSquared.reduce(0, +)
        
            
            var Gtau = zip(G, tau).map { $0 * $1 } //Multiply x, y, z components
            
            var GdotTau = Double(Gtau.reduce(0, +)) //add them together (equivalent to dot product)
            
            GdotTau = GdotTau*2*Double.pi //Should not be an array
            
   
            
            switch selectedBand {
                case "Si":
                a = 5.43
                V3S = -0.21*rydberg
                V8S = 0.04*rydberg
                V11S = 0.08*rydberg
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
                
                case "Ge":
                a = 5.66
                V3S = -0.23*rydberg
                V8S = 0.01*rydberg
                V11S = 0.06*rydberg
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
                
                case "Sn":
                a = 6.49
                V3S = -0.2*rydberg
                V8S = 0.00
                V11S = 0.06*rydberg
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
                
                case "GaP":
                a = 5.44
                V3S = -0.22*rydberg
                V8S = 0.03*rydberg
                V11S = 0.07*rydberg
                V3A = 0.12*rydberg
                V4A = 0.7*rydberg
                V11A = 0.02*rydberg
                
                case "GaAs":
                a = 5.64
                V3S = -0.23*rydberg
                V8S = 0.01*rydberg
                V11S = 0.06*rydberg
                V3A = 0.07*rydberg
                V4A = 0.05*rydberg
                V11A = 0.01*rydberg
                
                case "AlSb":
                a = 6.13
                V3S = -0.21*rydberg
                V8S = 0.02*rydberg
                V11S = 0.06*rydberg
                V3A = 0.06*rydberg
                V4A = 0.04*rydberg
                V11A = 0.02*rydberg
                
                case "InP":
                a = 5.86
                V3S = -0.23*rydberg
                V8S = 0.01*rydberg
                V11S = 0.06*rydberg
                V3A = 0.07*rydberg
                V4A = 0.05*rydberg
                V11A = 0.01*rydberg
                
                case "GaSb":
                a = 6.12
                V3S = -0.22*rydberg
                V8S = 0.0*rydberg
                V11S = 0.05*rydberg
                V3A = 0.06*rydberg
                V4A = 0.05*rydberg
                V11A = 0.01*rydberg
                
                case "InAs":
                a = 6.04
                V3S = -0.22*rydberg
                V8S = 0.0*rydberg
                V11S = 0.05*rydberg
                V3A = 0.08*rydberg
                V4A = 0.05*rydberg
                V11A = 0.03*rydberg
                
                case "InSb":
                a = 6.48
                V3S = -0.2*rydberg
                V8S = 0.0*rydberg
                V11S = 0.04*rydberg
                V3A = 0.06*rydberg
                V4A = 0.05*rydberg
                V11A = 0.01*rydberg
                
                case "ZnS":
                a = 5.41
                V3S = -0.22*rydberg
                V8S = 0.03*rydberg
                V11S = 0.07*rydberg
                V3A = 0.24*rydberg
                V4A = 0.14*rydberg
                V11A = 0.04*rydberg
                
                case "ZnSe":
                a = 5.65
                V3S = -0.23*rydberg
                V8S = 0.01*rydberg
                V11S = 0.06*rydberg
                V3A = 0.18*rydberg
                V4A = 0.12*rydberg
                V11A = 0.06*rydberg
                
                case "ZnTe":
                a = 6.07
                V3S = -0.22*rydberg
                V8S = 0.0*rydberg
                V11S = 0.05*rydberg
                V3A = 0.13*rydberg
                V4A = 0.1*rydberg
                V11A = 0.01*rydberg
                
                case "CdTe":
                a = 6.41
                V3S = -0.2*rydberg
                V8S = 0.0*rydberg
                V11S = 0.04*rydberg
                V3A = 0.15*rydberg
                V4A = 0.09*rydberg
                V11A = 0.04*rydberg
                
                default: //default to Si
                a = 5.43
                V3S = -0.21*rydberg
                V8S = 0.04*rydberg
                V11S = 0.08*rydberg
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
            
            }
            

        
            
            
            
            
            
            
            
            
            
            //pseudopotential symmetric and anti-symmetric form
            //
            //              s      s        A    A   - iG * r
            //V(r)  =  Σ ( S  (G) V   +  i S (G)V ) e
            //         G           G             G
            //
           
        
           
            var SS = cos(GdotTau) // Symmetric structure factor
            var SA = sin(GdotTau) // Anti-symmetric structure factor
            
            //V needs to be a summation over all G values
            //Only non-zero V are at these values
            
                if GG == 3 {
                    VS = V3S
                    VA = V3A
                    V += Complex<Double>(SS*VS, SA*VA)
                    
                }
                if GG == 4 {
                   VS = 0.0
                   VA = V4A
                    V += Complex<Double>(SS*VS, SA*VA)
                }
                if GG == 8 {
                   VS = V8S
                   VA = 0.0
                    V += Complex<Double>(SS*VS, SA*VA)
                    
                }
                if GG == 11 {
                    VS = V11S
                    VA = V11A
                    V += Complex<Double>(SS*VS, SA*VA)
                    
                }
                else {
                    V += Complex<Double>(0, 0)
                }
            
           
            
            
            
        
            
            
            
            
            
            
            
            
            
            
            
            var k = kData!.k
            
            
            
            
            
           
            let kPlusG = zip(k, G).map { $0 + $1 }
            let kGscalar = kPlusG.reduce(0, +)
            let kGSquared = pow(kGscalar, 2.0)
            let Hconstants = hbarsquareoverm
            let Hvalues = kGSquared*Hconstants
            
           
            let hamiltonian = Complex<Double>(Hvalues + V.real, V.imaginary)
              H.append(hamiltonian)
            
                
                
                
                
                
            
        
    }

        
        
        var HMatrix = [[Complex<Double>]](repeating: [Complex<Double>](repeating: Complex<Double>(0,0), count: 125), count: 125)
        
            for i in stride(from: 0, through: 124, by: 1) {
                for j in stride(from: 0, through: 124, by: 1) {

                    let ij = H[i]*H[j]
                    HMatrix[i][j] = ij





                }
            }
        
        
       
        
        
        
        
        
  
    }
  
    
   
}
