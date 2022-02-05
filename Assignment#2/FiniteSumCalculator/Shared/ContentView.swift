//
//  ContentView.swift
//  Shared
//
//  Created by Jasmine Panthee on 2/5/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var seriesSum = Series()
    
    @State var S1Text = "0.0"
    @State var S2Text = "0.0"
    @State var S3Text = "0.0"
    @State var errorText = "0.0"
    
    @State var sumUpText = "0.0"
    @State var sumDownText = "0.0"
    
    var body: some View {
           
           VStack{
               Text("Enter N")
                   .padding(.bottom, 0)
                       TextField("NText", value: $seriesSum.N,format: .number)
                   .padding(.horizontal)
               HStack {
                   VStack{
               Text("S1")
                   .padding(.bottom, 0)
                       TextField("S1Text", text: $S1Text)
                   .padding(.horizontal)
                   .frame(width: 100)
                   .padding(.top, 0)
                   .padding(.bottom,30)
               
           }
           VStack{
               Text("S2")
                   .padding(.bottom, 0)
               TextField("S2Text", text: $S2Text)
                   .padding(.horizontal)
                   .frame(width: 100)
                   .padding(.top, 0)
                   .padding(.bottom,30)
                   
               }
               }
               HStack{
                   VStack{
               Text("S3")
                   .padding(.bottom, 0)
                TextField("S2Text", text: $S3Text)
                   .padding(.horizontal)
                   .frame(width: 100)
                   .padding(.top, 0)
                   .padding(.bottom, 30)
                   }
                   
               }
               VStack{
           Text("Relative Error")
               .padding(.bottom, 0)
            TextField("errorText", text: $errorText)
               .padding(.horizontal)
               .frame(width: 100)
               .padding(.top, 0)
               .padding(.bottom, 30)
               }
               
               HStack{
                   VStack{
                   Text("S_up")
                       .padding(.bottom, 0)
                   TextField("sumUpText", text: $sumUpText)
                       .padding(.horizontal)
                       .frame(width: 100)
                       .padding(.top, 0)
                       .padding(.bottom,30)
                   }
                   HStack{
                       VStack{
                   Text("S_down")
                       .padding(.bottom, 0)
                    TextField("sumDownText", text: $sumDownText)
                       .padding(.horizontal)
                       .frame(width: 100)
                       .padding(.top, 0)
                       .padding(.bottom, 30)
                       }
                   }
                   }
        
               Button("Calculate", action: calculateSum)
                   .padding()
           }
           
           .padding()
               
           }
           
       
       
       func calculateSum() {
           
           let sum1 = seriesSum.calculate_S1(N: seriesSum.N)
                  S1Text = "\(sum1)"
           
           let sum2 = seriesSum.calculate_S2(N: seriesSum.N)
                  S2Text = "\(sum2)"
           
           let sum3 = seriesSum.calculate_S3(N: seriesSum.N)
                  S3Text = "\(sum3)"
           let error = (log10(abs((sum1 - sum3)/sum3)))
                  errorText = "\(error)"
           
           let sumUp = seriesSum.calculate_Sup(N: seriesSum.N)
                  sumUpText = "\(sumUp)"
           let sumDown = seriesSum.calculate_SDown(N: seriesSum.N)
                  sumDownText = "\(sumDown)"
           
       }
}
           
           
       

   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
