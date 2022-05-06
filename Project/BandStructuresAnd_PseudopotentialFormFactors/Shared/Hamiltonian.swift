//
//  Hamiltonian.swift
//  BandStructuresAnd_PseudopotentialFormFactors
//
//  Created by Jasmine Panthee on 4/1/22.
//

import Foundation
import Accelerate

class Hamiltonian: NSObject,ObservableObject{
    
    @Published var tau:[Double] = []
    @Published var g:[Double] = []
    
    var plotDataModel: PlotDataClass? = nil
    var kData: K_Generator? = nil
    

    let hbar :Double = 6.582e-16 //planks constant in eV
    let m_ev : Double = 0.511e6 //mass of electron in eV
    
    let hbarsq_m:Double = 7.62 //in eV
    
    let m_e:Double  = 9.11e-31
    //let c = ( hbar  ↑ 2 )/(2*m_e)
    
    //pseudopotential Hailtonian
    //
    //              2         2
    //  H  =   - ( ℏ  / 2m) ∇   +  V(r)
 
    
    
    //kinetic term
//        2
//       h                                              2
//T   =  -- ||( overrightarrow{k} +overrightarrow{G} )|| *delta_i,j //the delta ij part is taken care of by the hamiltonian 
//k     2m
//

    func KineticTerm(k:[Double], g:[Double])-> Double{
        let v: [Double] = k + g
        let constant =  (hbar  ↑ 2 )/(2*m_ev)
        //let constant = (hbarsq_m)
        //constant * dot product v*v
        var dotProductScalar = 0.0
        vDSP_dotprD(v, 1, v, 1, &dotProductScalar, vDSP_Length(v.count))
        return constant * dotProductScalar
    }
   
    //pseudopotential symmetric and anti-symmetric form
    //
    //              s      s        A    A   - iG * r
    //V(r)  =  Σ ( S  (G) V   +  i S (G)V ) e
    //                      G            G
    
    //need to pass the element here
    func Potentialterm(g:[Double],tau:(k_x:Double,k_y:Double, k_z:Double),band:String)->Double{
        //here we have to calculate the dot product of v and tau so we reconvert the tuple of doubles to array of doubles
        var tau_vec: [Double] = [0,0,0]
        tau_vec[0] = tau.k_x
        tau_vec[1] = tau.k_y
        tau_vec[2] = tau.k_z
        let band_Choice: String = band
        
        var V3S  = 0.0
        var V8S  = 0.0
        var V11S = 0.0
        var V3A  = 0.0
        var V4A  = 0.0
        var V11A = 0.0
        var VS   = 0.0 //symmetric
        var VA   = 0.0 //antisymmetric
        let ryd  = 13.6056980659 //rydberg constant
        var a    = 0.0 //initializing the lattice constant
        var V    = 0.0 //initializing potential value
        
        switch band_Choice {
            case "Si":
                a = 5.43
                V3S = -0.21*ryd
                V8S = 0.04*ryd
                V11S = 0.08*ryd
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
                
            case "Ge":
                a = 5.66
                V3S = -0.23*ryd
                V8S = 0.01*ryd
                V11S = 0.06*ryd
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
                
                case "Sn":
                a = 6.49
                V3S = -0.2*ryd
                V8S = 0.00
                V11S = 0.06*ryd
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
                
                case "GaP":
                a = 5.44
                V3S = -0.22*ryd
                V8S = 0.03*ryd
                V11S = 0.07*ryd
                V3A = 0.12*ryd
                V4A = 0.7*ryd
                V11A = 0.02*ryd
                
                case "GaAs":
                a = 5.64
                V3S = -0.23*ryd
                V8S = 0.01*ryd
                V11S = 0.06*ryd
                V3A = 0.07*ryd
                V4A = 0.05*ryd
                V11A = 0.01*ryd
                
                case "AlSb":
                a = 6.13
                V3S = -0.21*ryd
                V8S = 0.02*ryd
                V11S = 0.06*ryd
                V3A = 0.06*ryd
                V4A = 0.04*ryd
                V11A = 0.02*ryd
                
                case "InP":
                a = 5.86
                V3S = -0.23*ryd
                V8S = 0.01*ryd
                V11S = 0.06*ryd
                V3A = 0.07*ryd
                V4A = 0.05*ryd
                V11A = 0.01*ryd
                
                case "GaSb":
                a = 6.12
                V3S = -0.22*ryd
                V8S = 0.0*ryd
                V11S = 0.05*ryd
                V3A = 0.06*ryd
                V4A = 0.05*ryd
                V11A = 0.01*ryd
                
                case "InAs":
                a = 6.04
                V3S = -0.22*ryd
                V8S = 0.0*ryd
                V11S = 0.05*ryd
                V3A = 0.08*ryd
                V4A = 0.05*ryd
                V11A = 0.03*ryd
                
                case "InSb":
                a = 6.48
                V3S = -0.2*ryd
                V8S = 0.0*ryd
                V11S = 0.04*ryd
                V3A = 0.06*ryd
                V4A = 0.05*ryd
                V11A = 0.01*ryd
                
                case "ZnS":
                a = 5.41
                V3S = -0.22*ryd
                V8S = 0.03*ryd
                V11S = 0.07*ryd
                V3A = 0.24*ryd
                V4A = 0.14*ryd
                V11A = 0.04*ryd
                
                case "ZnSe":
                a = 5.65
                V3S = -0.23*ryd
                V8S = 0.01*ryd
                V11S = 0.06*ryd
                V3A = 0.18*ryd
                V4A = 0.12*ryd
                V11A = 0.06*ryd
                
                case "ZnTe":
                a = 6.07
                V3S = -0.22*ryd
                V8S = 0.0*ryd
                V11S = 0.05*ryd
                V3A = 0.13*ryd
                V4A = 0.1*ryd
                V11A = 0.01*ryd
                
                case "CdTe":
                a = 6.41
                V3S = -0.2*ryd
                V8S = 0.0*ryd
                V11S = 0.04*ryd
                V3A = 0.15*ryd
                V4A = 0.09*ryd
                V11A = 0.04*ryd
                
                default: //default to Si
                a = 5.43
                V3S = -0.21*ryd
                V8S = 0.04*ryd
                V11S = 0.08*ryd
                V3A = 0.0
                V4A = 0.0
                V11A = 0.0
        }
        
                
        var dotProductScalar = 0.0
        vDSP_dotprD(g, 1, tau_vec, 1, &dotProductScalar, vDSP_Length(g.count))
        
        //Structure factors
        let SS = cos(dotProductScalar) //symmetric
        let SA = sin(dotProductScalar) //antisymmetric
        
        //The first five of the reciprocal lattice vectors have magnitude of 0,3,4,8,11. Only those have nonzero potential.
        //The symmetric structure factor for G^2 = 4 is 0
        //The antisymmetric structure factor is 0 for G^2 = 0 and 8
        //only three symmetric and three antisymmetric form factors to be determines
            
        var G_square = 0.0
        vDSP_dotprD(g, 1, g, 1, &G_square, vDSP_Length(g.count))
        
            if G_square == 3{
                VS = V3S
                VA = V3A
                V += ( SS * VS + sqrt(-1) * SA * VA )
            }
           
            if G_square == 4{
                VS = 0.0
                VA = V4A
                V += ( SS * VS + sqrt(-1) * SA * VA )
            }
            
            if G_square == 8{
                VS = V8S
                VA = 0.0
                V += ( SS * VS + sqrt(-1) * SA * VA )
            }
            
            if G_square == 11{
                VS = V11S
                VA = V11A
                V += ( SS * VS + sqrt(-1) * SA * VA )
            }
            
        return V
    }

    func lattice_const(band:String)->Double{
        var a:Double = 0.0
        switch band{
            case "Si":
            a = 5.43
            case "Ge":
            a = 5.6
            case "Sn":
            a = 6.49
            case "GaP":
            a = 5.44
            case "GaAs":
            a = 5.64
            case "AlSb":
            a = 6.13
            case "InP":
            a = 5.86
            case "GaSb":
            a = 6.12
            case "InAs":
            a = 6.04
            case "InSb":
            a = 6.48
            case "ZnS":
            a = 5.41
            case "ZnSe":
            a = 5.65
            case "ZnTe":
            a = 6.07
            case "CdTe":
            a = 6.41
            default: //default to Si
            a = 5.43
        }
        return a
    }
    //this is supposed to return an nXn matrix
        func Hamiltonian(/*lattice_constant: Double,form_factors:[Double],*/band:String, waveVec_k: [Double]/*,reciprocal_basis:(k_x:Double,k_y:Double,k_z:Double)*/,states:Int)->[[Double]]{
        
            
        let band_choice:String = band
        let a: Double = lattice_const(band:band_choice)
            
        let Kinetic_c :Double = (2.0 * .pi / a) ↑ 2.0
        let wave_vec: [Double] = waveVec_k
        let bandChoice:String = band
        //let offset:Double = (1/8)*np.ones(3)
        
        //States determines the size of the matrix. Each of the three reciprocal lattice vectors can take on n↑3 x n↑3 matrix
        
        let n:Int = states ↑ 3
        
        //Reciprocal lattive vector
        //G = hb1 + kb2 + lb3
        //So calculating the coefficients we require
            
        //Primitive Vectors
        let b1:(k_x:Double,k_y:Double,k_z:Double) = (-1.0,1.0,1.0)
        let b2:(k_x:Double,k_y:Double,k_z:Double) = (1.0,-1.0,1.0)
        let b3:(k_x:Double,k_y:Double,k_z:Double) = (1.0,1.0,-1.0)
            
        let basis3D: [(k_x:Double,k_y:Double,k_z:Double)] = [b1,b2,b3]
        
        
        func coefficients(m: Int) -> (h:Int, k:Int, l:Int){
            
//            let n:Int = (states ↑ 3) / 2
//            let s:Int = m + n
//            let floor: Int = states/2
//
//            let h:Int = s / states ↑ 2 - floor
//            let k:Int = s % states ↑ 2 / states - floor
//            let l:Int = s % states - floor
            
            let n:Int = Int(floor(Double((states ↑ 3) / 2)))
            let s:Int = m + n
            let flr: Int = Int(floor(Double(states)/2))
            
            let h:Int = Int(floor(Double((s/states) ↑ 2) - Double(flr)))
            let k:Int = Int(floor(Double((s % states) ↑ 2) / Double(states)) - Double(flr))
            let l:Int = s % states - flr
    
            return (h,k,l)
            
        }
        
            
        //define h as an nXn matrix
        //let h: [[Double]] = Double[]
        //var Hamitonian_matrix = (0..<n).map { row in (0..<n).map { col in n * row + col}}
        
        
        var Hamiltonian_matrix = Array(repeating: Array(repeating: 0.0, count: n), count: n)
        
        //print(Hamitonian_matrix)
        
        for dim in 0..<3{
            let basis = basis3D[dim]
        for i in 1..<n{
            
            for j in 1..<n{
                
                var g: [Double] = [0, 0, 0]  //initializing reciprocal lattice vector
                
                //kinetic terms are non-zero only along the diagonal
                if (i == j){ //row ==col
//                    g[0] = Double(coefficients(m: i-n/2).h) * basis.k_x
//                    g[1] = Double(coefficients(m: i-n/2).k) * basis.k_y
//                    g[2] = Double(coefficients(m: i-n/2).l) * basis.k_z

                    g[0] = Double(coefficients(m: i-n/2).h) * basis.k_x
                    g[1] = Double(coefficients(m: i-n/2).k) * basis.k_y
                    g[2] = Double(coefficients(m: i-n/2).l) * basis.k_z
                    
                    //let bob = Kinetic_c * KineticTerm(k:wave_vec , g:g)
                    //g = coefficients(m: i-n/2) * basis
                    Hamiltonian_matrix[i][j] = Kinetic_c*KineticTerm(k:wave_vec , g:g)
                                               
                    
                }
                
                //only potential terms for the off-diagonal
                else {
                    g[0] = Double(coefficients(m: i-n/2).h) * basis.k_x
                    g[1] = Double(coefficients(m: i-n/2).k) * basis.k_y
                    g[2] = Double(coefficients(m: i-n/2).l) * basis.k_z
                    
                    var dotProductScalar = 0.0
                    vDSP_dotprD(g, 1, g, 1, &dotProductScalar, vDSP_Length(g.count))
                    
                    //getting the form factors from the reciprocal lattice vector
                    //factors = ff.get(dotProductScalar)
                    /*if factors == 0 {
                        Hamiltonian_matrix[i][j] = 0}
                    else {
                    Hamiltonian_matrix[i][j]  = Potentialterm(g: g, tau: basis, sym: factors)
                    }*/
                    // no need to call a form factos object beacuse the potential function takes care of it
                    //kinetic term + potential term
//                    Hamiltonian_matrix[i][j]  = Kinetic_c * KineticTerm(k:wave_vec, g:g) +  Potentialterm(g: g, tau: basis, band: bandChoice)
                    Hamiltonian_matrix[i][j]  = Potentialterm(g: g, tau: basis, band: bandChoice)
                }
            }
            
        }
        }

        //print(Hamiltonian_matrix)
        return Hamiltonian_matrix
    }
    
    
}
