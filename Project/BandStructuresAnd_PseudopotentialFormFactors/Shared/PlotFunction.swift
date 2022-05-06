//
//  PlotFunction.swift
//  BandStructuresAnd_PseudopotentialFormFactors
//
//  Created by Jasmine Panthee on 5/1/22.
//

import Foundation
import SwiftUI
import CorePlot

class PlotBands: ObservableObject {
    var plotDataModel: PlotDataClass? = nil
    
    let Energy = BandStructure()
    
    //temp parameter declaration
    let xMin = 0.0
    let xMax = 10.0
    let xStep = 0.01
    
    @MainActor func plotBands(energyEigenvalues:[Double]) {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = 0.0
        plotDataModel!.changingPlotParameters.xMax = xMax
        plotDataModel!.changingPlotParameters.xMin = xMin
        plotDataModel!.changingPlotParameters.xLabel = "G"
        plotDataModel!.changingPlotParameters.yLabel = "E"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "Band Structure"
        
        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        //gets energy eigenvalues
        let dataPoints:[Double] = energyEigenvalues
        
        
//        for i in 0...dataPoints.endIndex-1 {
//            plotData.append(contentsOf: (dataPoints[i],))
//        }
            
        plotDataModel!.appendData(dataPoint: plotData)
        
    }
}


