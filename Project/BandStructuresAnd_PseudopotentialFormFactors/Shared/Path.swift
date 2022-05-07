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
        @Published var k_vec:[[Double]] = [[]]
        
        // symmetry points in the Brillouin zone
        
     
        var k:[Double] = [0.0,0.0,0.0]
        
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
      func kGenerator() -> [[Double]]{
            for k_x in stride(from: 0.5, to: 0.0, by: -0.05) {
                       for k_y in stride(from: 0.5, to: 0.0, by: -0.05){
                           for k_z in stride(from: 0.5, to: 0.0, by: -0.05) {
                               k[0]=k_x
                               k[1]=k_y
                               k[2]=k_z
                               k_vec.append(k)
                   }
                   }
                   }
            //Gamma to X:

            k_x = 0.0
            k_y = 0.0
            k_z = 0.0


            for k_x in stride(from: 0.0, to: 1, by: 0.1){
                k[0]=k_x
                k[1]=k_y
                k[2]=k_z
                k_vec.append(k)
                }

            //X to K:
            k_x = 1.0
            k_y = 0.0
            k_z = 0.0

            for k_x in stride(from: 1.0, to: 0.75, by: 0.025) {
                for k_y in stride(from: 0.0, to: 0.75, by: 0.075) {
                    k[0]=k_x
                    k[1]=k_y
                    k[2]=k_z
                    k_vec.append(k)
                    }
                    }

            //K to Gamma
            k_x = 0.75
            k_y = 0.75
            k_z = 0.0
            for k_x in stride(from: 0.75, to: 0.0, by: -0.075) {
                for k_y in stride(from: 0.75, to: 0.0, by: -0.075) {
                    k[0]=k_x
                    k[1]=k_y
                    k[2]=k_z
                    k_vec.append(k)
                    }
                }
                 //print(k)
             return k_vec
//
             }
//
    }
        

//}
