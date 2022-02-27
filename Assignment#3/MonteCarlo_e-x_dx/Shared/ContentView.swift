//
//  ContentView.swift
//  Shared
//
//  Created by Jasmine Panthee on 2/4/22.
//

import SwiftUI

struct ContentView: View {
       @State var totalGuesses = 0.0
       @State var totalIntegral = 0.0
       @State var y = 1.0
       @State var guessString = "23458"
       @State var totalGuessString = "0"
       @State var e_xAreaString = "0.0"
       
       
       // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
       @ObservedObject var monteCarlo = MonteCarlo_ex(withData: true)
       
       //Setup the GUI View
       var body: some View {
           HStack{
               
               VStack{
                   
                   VStack(alignment: .center) {
                       Text("Guesses")
                           .font(.callout)
                           .bold()
                       TextField("# Guesses", text: $guessString)
                           .padding()
                   }
                   .padding(.top, 5.0)
                   
                   VStack(alignment: .center) {
                       Text("Total Guesses")
                           .font(.callout)
                           .bold()
                       TextField("# Total Guesses", text: $totalGuessString)
                           .padding()
                   }
                   
                   VStack(alignment: .center) {
                       Text("e_x dx")
                           .font(.callout)
                           .bold()
                       TextField("# e_x dx", text: $e_xAreaString)
                           .padding()
                   }
                   
                   Button("Cycle Calculation", action: {Task.init{await self.calculateArea_e_xdx()}})
                       .padding()
                       .disabled(monteCarlo.enableButton == false)
                   
                   Button("Clear", action: {self.clear()})
                       .padding(.bottom, 5.0)
                       .disabled(monteCarlo.enableButton == false)
                   
                   if (!monteCarlo.enableButton){
                       
                       ProgressView()
                   }
                   
                   
               }
               .padding()
               
               //DrawingField
               
               
               drawingView(redLayer:$monteCarlo.insideData, blueLayer: $monteCarlo.outsideData)
                   .padding()
                   .aspectRatio(1, contentMode: .fit)
                   .drawingGroup()
               // Stop the window shrinking to zero.
               Spacer()
               
           }
       }
       
       func calculateArea_e_xdx() async {
           
           
           monteCarlo.setButtonEnable(state: false)
           
           monteCarlo.guesses = Double(guessString)!
           monteCarlo.y = y
           monteCarlo.totalGuesses = Double(totalGuessString) ?? Double(0.0)
           
           await monteCarlo.calculateArea_e_x()
           
           totalGuessString = monteCarlo.totalGuessesString
           
           e_xAreaString =  monteCarlo.e_xAreaString
           
           monteCarlo.setButtonEnable(state: true)
           
       }
       
       func clear(){
           
           guessString = "23458.0"
           totalGuessString = "0.0"
           e_xAreaString =  ""
           monteCarlo.totalGuesses = 0.0
           monteCarlo.totalIntegral = 0.0
           monteCarlo.insideData = []
           monteCarlo.outsideData = []
           monteCarlo.firstTimeThroughLoop = true
           
       }
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
