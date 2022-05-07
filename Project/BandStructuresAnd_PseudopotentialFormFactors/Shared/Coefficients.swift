//
//  Coefficients.swift
//  BandStructuresAnd_PseudopotentialFormFactors
//
//  Created by Jasmine Panthee on 4/1/22.
//

//function for the reciprocal lattice vector that takes the form
//
import Foundation
class Coefficients: ObservableObject{
    

    func coefficients(m: Int,states:Int) -> (h:Int, k:Int, l:Int){
        
        let n:Int = Int( (states ↑ 3) / 2 )// integer division here
        let s:Int = m + n
        let floor:Int = states/2
        
        let h:Int = s / states ↑ 2 - floor
        let k:Int = s % states ↑ 2 / states - floor
        let l:Int = s % states - floor
        
        return (h,k,l)
        
    }
}

