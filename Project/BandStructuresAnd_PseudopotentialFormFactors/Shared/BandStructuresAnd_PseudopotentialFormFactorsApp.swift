//
//  BandStructuresAnd_PseudopotentialFormFactorsApp.swift
//  Shared
//
//  Created by Jasmine Panthee on 4/1/22.
//

import SwiftUI

@main
struct BandStructuresAnd_PseudopotentialFormFactorsApp: App {
    
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }
}
