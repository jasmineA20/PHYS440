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
    @State var eigenvalues: [[Double]] = [[]]
    
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
    }
       
}
                       }
    
    //Resetting parameters
    func clear(){
        myk.k = []
        //myBands.H = Array(repeating: Array(repeating: 0.0, count: n), count: n)
        myBands.g = []
    }
    
    
    func calculateEnergy(){
        //flatarray.plotDataModel = self.plotDataModel
        
//        let dataPoint: plotDataType = [.X: 0.0, .Y: (zerothError)]
//        plotDataModel!.appendData(dataPoint: [dataPoint])
        
        //g_vec.append(b_vec)
        
       
        
        let num:Int = myk.kGenerator().count
        
       
        
        //myk.kGenerator has the k_vecs for moving to and from all the symmetry points defined in the paper
        for i in stride(from:0, to:num, by:1){
            //print(myk.kGenerator())
            let thisHamilt = myBands.Hamiltonian(band: selectedBand, waveVec_k: myk.kGenerator()[i], states: 3)
            let N = Int32(thisHamilt.count)
            let flatArray: [Double] = pack2dArray(arr: thisHamilt, rows: Int(N), cols: Int(N))
            energy.calculateEigenvalues(arrayForDiagonalization: flatArray)
            eigenvalues.append(flatArray)
        }


//        plotDataModel.changingPlotParameters.yMax = 20.0
//        plotDataModel.changingPlotParameters.yMin = -42000.1
//        plotDataModel.changingPlotParameters.xMax = 125.0
//        plotDataModel.changingPlotParameters.xMin = 20.0
//        plotDataModel.changingPlotParameters.xLabel = "k-vec"
//        plotDataModel.changingPlotParameters.yLabel = "EnergyEigenvalue"
//        plotDataModel.changingPlotParameters.lineColor = .red()
//        plotDataModel.changingPlotParameters.title = "Band Structures"
        
        for i in stride(from: 0, to: eigenvalues.count, by: 1){
   //this ok
            //getting magnitude of k_vec
            var xpoint: Double = sqrt(myk.kGenerator()[i][0] ↑ 2
                                      + myk.kGenerator()[i][1] ↑ 2
                                      + myk.kGenerator()[i][2] ↑ 2)

            //plot all of the energy eigenvlaues obtained for a given k-vector
            for j in stride(from: 0, to: eigenvalues[i].count, by: 1){
                    let dataPoint: plotDataType = [.X: (xpoint), .Y : eigenvalues[i][j]]
                    self.plotDataModel.appendData(dataPoint: [dataPoint])
            }

        }
        
        print(eigenvalues)
        
        
    }
    
        func pack2dArray(arr: [[Double]], rows: Int, cols: Int) -> [Double] {
                var resultArray = Array(repeating: 0.0, count: rows*cols)
            
                for Iy in 0...cols-1 {
                    for Ix in 0...rows-1 {
                        let index = Iy * rows + Ix
                        //getting nan for some entries so temp solutio?
                        //not needed anymore but still keeping
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






