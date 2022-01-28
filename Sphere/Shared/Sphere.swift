//
//  Sphere.swift
//  Sphere
//
//  Created by Jasmine Panthee on 1/27/22.
//

import SwiftUI

class Sphere: SphereA
{
    var radius = 0.0
    //Calculate volume of sphere by given radius
    func initWithRadius(passedRadius: Double) async -> Bool {
          
        radius = passedRadius
          
        

            let _ = await withTaskGroup(of:  Void.self) { taskGroup in



                taskGroup.addTask { let _ = await self.calculateVolume(r: self.radius)}
                taskGroup.addTask { let _ = await self.calculateSurfaceArea(r: self.radius)}
                taskGroup.addTask { let _ = await self.calculateBoundBoxVolume(r: self.radius)}
                taskGroup.addTask { let _ = await self.calculateBoundBoxSurfaceArea(r: self.radius)}

            }

            await setButtonEnable(state: true)

    return true
          
          
    }


    //Calculate Volume and Surface Area of the sphere
    //Calculate the volume of a bounding box, Suface area of the bounding box of the sphere
    //Parameterers:
    //-majorAxis: radius of the sphere
    //-minorAxis: radius of the sphere
  
    override func calculateVolume(r:Double) async -> Double{
        //volume = (4/3)πr^3 r->radius
        let calculatedVolume = (4/3)*Double.pi*(r*r*r)
        let newVolumeText    = String(format: "%7.5f",calculatedVolume)
    
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volumeVlaue:calculatedVolume)
    
        return calculatedVolume
    }
    
}
