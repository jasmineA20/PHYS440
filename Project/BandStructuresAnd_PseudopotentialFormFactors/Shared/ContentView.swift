//
//  ContentView.swift
//  Shared
//
//  Created by Jasmine Panthee on 4/1/22.
//

import SwiftUI
import Accelerate
//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Terry on 1/23/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @EnvironmentObject var plotDataModel :PlotDataClass
    @State var xInput: String = "\(Double.pi/2.0)"
    
    let newHamilt = Hamiltonian()
    
    
    //@State var a = 5.43 //a given in Angstroms
    @State var k:[Double] = []
    @State var g:[Double] = []
    @State var tau:[Double] = []
    @State var V = 0.0
    
    @ObservedObject var myk = K_Generator()
    @ObservedObject var myBands = Hamiltonian()
    @ObservedObject var energy = BandStructure()
    @ObservedObject var plot = PlotBands()
    @ObservedObject private var dataCalculator = CalculatePlotData()
    
    
    @State var bandTypes = ["AlSb", "CdTe", "GaAs", "GaP", "GaSb", "Ge", "InAs", "InP", "InSb", "Si", "Sn", "ZnS", "ZnSe", "ZnTe"]
    @State var selectedBand = "Si"

  
    

    var body: some View {
        
        VStack{
                     
                           CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                               .setPlotPadding(left: 10)
                               .setPlotPadding(right: 10)
                               .setPlotPadding(top: 10)
                               .setPlotPadding(bottom: 10)
                               .padding()
                           
                           Divider()
               
               
        VStack{
               
            Picker("Select the Semiconductor:", selection: $selectedBand) {
                
                                   ForEach(bandTypes, id: \.self) {
                                       Text($0)
                                   }
            }
            
            HStack{
                            Button("Calculate Energy", action: {self.calculateEnergy()} )
                            .padding()
                            
                        }
            
            HStack{
                            Button("Clear", action: {self.clear()})
                                .padding(.bottom, 5.0)
                                
                        }
//            HStack{
//                Button("Plot Selected Band", action: {self.plotButton(BandChoice: selectedBand)} )
//                    .padding()
//        }
    }
       
}
                       }
        
//    func plotButton (viewChoice: String, potentialType: String) {
//
//    }
    
    //Resetting parameters
    func clear(){
        //print (myk.k)
        myk.k = []
        //myBands.H = Array(repeating: Array(repeating: 0.0, count: n), count: n)
        myBands.g = []
    }
    
    
    func calculateEnergy(){
        //reciprocal lattice vectors in terms of primitive lattice
        //reciprocal of fcc is basis of bcc

        //flatarray.plotDataModel = self.plotDataModel
        
//        let dataPoint: plotDataType = [.X: 0.0, .Y: (zerothError)]
//        plotDataModel!.appendData(dataPoint: [dataPoint])
        
       
        //g_vec.append(b_vec)
        let thisHamilt = myBands.Hamiltonian(/*lattice_constant: a,*/ band: selectedBand, waveVec_k: myk.k, /*reciprocal_basis: (1.0,1.0,1.0),*/states: 3)
        
        //print(myk.k)
        let N = Int32(thisHamilt.count)
        let flatArray: [Double] = pack2dArray(arr: thisHamilt, rows: Int(N), cols: Int(N))
        energy.calculateEigenvalues(arrayForDiagonalization: flatArray)
    
        
//        plotDataModel.changingPlotParameters.yMax = 20.0
//        plotDataModel.changingPlotParameters.yMin = -42000.1
//        plotDataModel.changingPlotParameters.xMax = 125.0
//        plotDataModel.changingPlotParameters.xMin = 20.0
//        plotDataModel.changingPlotParameters.xLabel = "k-vec"
//        plotDataModel.changingPlotParameters.yLabel = "EnergyEigenvalue"
//        plotDataModel.changingPlotParameters.lineColor = .red()
//        plotDataModel.changingPlotParameters.title = "Band Structures"
            
        for i in stride(from: 0, to: flatArray.count, by: 1){
            
            let dataPoint: plotDataType = [.X: Double(i), .Y : flatArray[i] ]
            self.plotDataModel.appendData(dataPoint: [dataPoint])
        }
        
        print(flatArray)
        
        
    }
    
        func pack2dArray(arr: [[Double]], rows: Int, cols: Int) -> [Double] {
                var resultArray = Array(repeating: 0.0, count: rows*cols)
            
                for Iy in 0...cols-1 {
                    for Ix in 0...rows-1 {
                        let index = Iy * rows + Ix
                        //getting nan for some entries so temp solution?
                        if (arr[Ix][Iy].isNaN) {
                            resultArray[index] = 0}
                        else{
                            resultArray[index] = arr[Ix][Iy]}
                    }
                }
                return resultArray
            }
        
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






