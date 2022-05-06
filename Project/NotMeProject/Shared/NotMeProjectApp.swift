//
//  NotMeProjectApp.swift
//  Shared
//
//  Created by Jasmine Panthee on 5/1/22.
//

import SwiftUI

@main
struct NotMeProjectApp: App {
    
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup  {
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

