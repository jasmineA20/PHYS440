//
//  ContentView.swift
//  Shared
//
//  Created by Jasmine Panthee on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var SphereModel = Sphere()
    @State var radiusString = "1.0"
    
    var body: some View {
        VStack{
            Text("Radius")
                           .padding(.top)
                           .padding(.bottom, 0)
                       TextField("Enter Radius", text: $radiusString, onCommit: {Task.init {await self.calculateSphere()}})
                           .padding(.horizontal)
                           .frame(width: 100)
                           .padding(.top, 0)
                           .padding(.bottom, 30)
                       HStack {
                           VStack{
                       Text("Volume")
                           .padding(.bottom, 0)
                       TextField("", text: $SphereModel.VolumeText)
                           .padding(.horizontal)
                           .frame(width: 100)
                           .padding(.top, 0)
                           .padding(.bottom,30)
                        }
                           
                                      }
            HStack{
                           VStack{
                       Text("SurfaceArea")
                           .padding(.bottom, 0)
                       TextField("", text: $SphereModel.SurfaceAreaText)
                           .padding(.horizontal)
                           .frame(width: 100)
                           .padding(.top, 0)
                           .padding(.bottom, 30)
                           }

                       
                       
                   }
            
            HStack{
                           VStack{
                       Text("BoundBoxVolume")
                           .padding(.bottom, 0)
                       TextField("", text: $SphereModel.BoundBoxVolumeText)
                           .padding(.horizontal)
                           .frame(width: 100)
                           .padding(.top, 0)
                           .padding(.bottom, 30)
                           }
                       
                   }
            
            HStack{
                           VStack{
                       Text("BoundBoxSurfaceArea")
                           .padding(.bottom, 0)
                       TextField("", text: $SphereModel.BoundBoxSurfaceAreaText)
                           .padding(.horizontal)
                           .frame(width: 100)
                           .padding(.top, 0)
                           .padding(.bottom, 30)
                           }

                       
                       
                   }
                   
            
                   
                   Button("Calculate", action: {Task.init { await self.calculateSphere()}})
                       .padding(.bottom)
                       .padding()
                       .disabled(SphereModel.enableButton == false)
                   
                }
        
    }
    func calculateSphere() async{
        SphereModel.setButtonEnable(state:false)
        let _: Bool = await SphereModel.initWithRadius(passedRadius: Double(radiusString)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


