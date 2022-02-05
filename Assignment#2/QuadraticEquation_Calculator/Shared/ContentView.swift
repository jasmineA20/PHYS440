//
//  ContentView.swift
//  Shared
//
//  Created by Jasmine Panthee on 2/5/22.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var quadCalculator = QuadraticEquation()
    
       @State var x_minusText = "0.0"
       @State var x_plusText = "0.0"
       @State var xp_minusText = "0.0"
       @State var xp_plusText = "0.0"
       var body: some View {
           VStack{
               Text("Enter a,b,c for ax^2 + bx + c")
                       .padding()
            HStack{
               Text("a")
                   .padding()
                TextField("aText", value: $quadCalculator.a,format: .number)
               //TextField("aText", text: $aText)
                   //.padding()
        
               
               Text("b")
                   .padding()
               
                TextField("bText",  value: $quadCalculator.b,format: .number)
               //TextField("bText" , text: $bText)
                  // .padding()
                
                
               Text("c")
                   .padding()
                
                TextField("cText", value: $quadCalculator.c,format: .number)
               //TextField("cText", text: $cText)
                   // .padding()
               }
               
               Text("Soluions using the first formula")
                   .padding()
               HStack{
                   VStack{
                       Text("Minus")
                       
                       TextField("x_minusText", text: $x_minusText)
                           .padding()
                       
                   }
                   VStack{
                       Text("Plus")
                       TextField("x_plusText", text: $x_plusText)
                           .padding()
                   }
               }
               
               Text("Solutions using the second formula")
                   .padding()
               HStack{
                   VStack{
                       
                       Text("Minus")
                       TextField("xp_minusText", text: $xp_minusText)
                           .padding()
                       
                   }
                   VStack{
                       Text("Plus")
                       TextField("xp_plusText", text: $xp_plusText)
                           .padding()
                   }
               }
           }
           
           HStack {
               
               Button("Calculate", action: calculateQuad)
                   .padding()
           }
           
           .padding()
           Text("nan for complex solutions")
       }
    
    func  calculateQuad () {
        
               
        let x_minus = quadCalculator.x_minusCalculator(a:quadCalculator.a,b:quadCalculator.b,c:quadCalculator.c)
               x_minusText = "\(x_minus)"
        
        let x_plus = quadCalculator.x_plusCalculator(a:quadCalculator.a,b:quadCalculator.b,c:quadCalculator.c)
               x_plusText = "\(x_plus)"
        
        let xp_plus = quadCalculator.xp_plusCalculator(a:quadCalculator.a,b:quadCalculator.b,c:quadCalculator.c)
               xp_plusText =  "\(xp_plus)"
               
        let xp_minus = quadCalculator.xp_minusCalculator(a:quadCalculator.a,b:quadCalculator.b,c:quadCalculator.c)
               xp_minusText =  "\(xp_minus)"
               
               
               
                   }
        
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
