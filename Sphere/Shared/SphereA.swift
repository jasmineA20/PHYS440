//
//  SphereA.swift
//  Sphere
//
//  Created by Jasmine Panthee on 1/27/22.
//

import SwiftUI

class SphereA: NSObject, ObservableObject{
    var Radius = 0.0
    @Published var Volume                  = 0.0
    @Published var SurfaceArea             = 0.0
    @Published var BoundBoxVolume          = 0.0
    @Published var BoundBoxSurfaceArea     = 0.0
    @Published var VolumeText              = ""
    @Published var SurfaceAreaText         = ""
    @Published var BoundBoxVolumeText      = ""
    @Published var BoundBoxSurfaceAreaText = ""
    @Published var enableButton            = true
    
    func initWithRadius(r: Double) async->Bool{
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            
            taskGroup.addTask { let _ = await self.calculateVolume(r: self.Radius)}
            taskGroup.addTask { let _ = await self.calculateSurfaceArea(r: self.Radius)}
            taskGroup.addTask { let _ = await self.calculateBoundBoxVolume(r: self.Radius)}
            taskGroup.addTask { let _ = await self.calculateBoundBoxSurfaceArea(r: self.Radius)}
    }
        await setButtonEnable(state: true)
        
        return true
    }
 
    func calculateVolume(r:Double) async->Double{
        
        let calculatedVolume = (4/3)*Double.pi*(r*r*r)
        let newVolumeText = String(format: "%7.5f",calculatedVolume)
        
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volumeVlaue: calculatedVolume)
        
        return calculatedVolume
    }
    
    func calculateSurfaceArea(r: Double) async ->Double{
        let calculatedSurfaceArea = 4*Double.pi*(r*r)
        let newSurfaceAreaText = String(format: "%7.5f",calculatedSurfaceArea)
        
        await updateSurfaceArea(SurfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(SurfaceAreaVlaue: calculatedSurfaceArea)
        
        return calculatedSurfaceArea
    }
    
    func calculateBoundBoxVolume(r: Double) async ->Double{
        let calculatedBoundBoxVolume = r*r*r
        let newBoundBoxVolumeText = String(format: "%7.5f",calculatedBoundBoxVolume)
        
        await updateBoundBoxVolume(BoundBoxVolumeTextString: newBoundBoxVolumeText)
        await newBoundBoxVolumeValue(BoundBoxVolumeVlaue: calculatedBoundBoxVolume)
        
        return calculatedBoundBoxVolume
    }
    
    func calculateBoundBoxSurfaceArea(r: Double) async ->Double{
        let calculatedBoundBoxSurfaceArea = 6*r*r
        let newBoundBoxSurfaceAreaText = String(format: "%7.5f",calculatedBoundBoxSurfaceArea)
        
        await updateBoundBoxSurfaceArea(BoundBoxSurfaceAreaTextString: newBoundBoxSurfaceAreaText)
        await newBoundBoxSurfaceAreaValue(BoundBoxSurfaceAreaVlaue: calculatedBoundBoxSurfaceArea)
        
        return calculatedBoundBoxSurfaceArea
    }
    
    @MainActor func setButtonEnable(state:Bool){
        if state{
            Task.init{
                await MainActor.run{
                    
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init{
                await MainActor.run{
                    self.enableButton = false
                }
            }
        }
    }
    
    @MainActor func updateVolume(volumeTextString: String){
        VolumeText = volumeTextString
    }
    @MainActor func newVolumeValue(volumeVlaue: Double){
        self.Volume = volumeVlaue
    }
    
    
    @MainActor func updateSurfaceArea(SurfaceAreaTextString: String){
        SurfaceAreaText = SurfaceAreaTextString
    }
    @MainActor func newSurfaceAreaValue(SurfaceAreaVlaue: Double){
        self.SurfaceArea = SurfaceAreaVlaue
    }
    
    
    @MainActor func updateBoundBoxVolume(BoundBoxVolumeTextString: String){
        BoundBoxVolumeText = BoundBoxVolumeTextString
    }
    @MainActor func newBoundBoxVolumeValue(BoundBoxVolumeVlaue: Double){
        self.BoundBoxVolume = BoundBoxVolumeVlaue
    }
    
    @MainActor func updateBoundBoxSurfaceArea(BoundBoxSurfaceAreaTextString: String){
        BoundBoxSurfaceAreaText = BoundBoxSurfaceAreaTextString
    }
    @MainActor func newBoundBoxSurfaceAreaValue(BoundBoxSurfaceAreaVlaue: Double){
        self.BoundBoxSurfaceArea = BoundBoxSurfaceAreaVlaue
    }
}
