//
//  Path.swift
//  BandStructuresAnd_PseudopotentialFormFactors
//
//  Created by Jasmine Panthee on 4/1/22.
//

import Foundation
//class path:ObservableObject{

//Here we need a function for creating a path of n k-points across the brillouin zone
    class K_Generator : NSObject, ObservableObject{
        @Published var k:[Double] = []
        
        // symmetry points in the Brillouin zone
        
        let G:[Double] = [0, 0, 0]
        let X:[Double] = [1, 0, 0]
        let K:[Double] = [0.75,0.75,0]
        let L:[Double] = [1/2, 1/2, 1/2]
        let W:[Double] = [1, 0.5, 0]
        let U:[Double] = [0.75, 0.75, 0]
        
        var k_x = 0.5
        var k_y = 0.5
        var k_z = 0.5
        
        
        //Generating points from L to Gamma
        func kGenerator() -> [Double]{
            for k_x in stride(from: 0.5, to: 0.0, by: -0.05) {
                       for k_y in stride(from: 0.5, to: 0.0, by: -0.05){
                           for k_z in stride(from: 0.5, to: 0.0, by: -0.05) {
                               k.append(k_x + k_y + k_z)
                   }
                   }
                   }
            //Gamma to X:
            k_x = 0.0
            k_y = 0.0
            k_z = 0.0
                    
            for k_x in stride(from: 0.0, to: 1, by: 0.1){
                k.append(k_x + k_y + k_z)
                }
                    
            //X to K:
            k_x = 1.0
            k_y = 0.0
            k_z = 0.0
                    
            for k_x in stride(from: 1.0, to: 0.75, by: 0.025) {
                for k_y in stride(from: 0.0, to: 0.75, by: 0.075) {
                    k.append(k_x + k_y + k_z)
                    }
                    }
                    
            //K to Gamma
            k_x = 0.75
            k_y = 0.75
            k_z = 0.0
            for k_x in stride(from: 0.75, to: 0.0, by: -0.075) {
                for k_y in stride(from: 0.75, to: 0.0, by: -0.075) {
                    k.append(k_x + k_y + k_z)
                    }
                }
                 //print(k)
                 return k
                 
                }
              
    }
        

//}
