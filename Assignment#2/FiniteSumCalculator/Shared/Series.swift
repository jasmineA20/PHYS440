//
//  Series.swift
//  FiniteSumCalculator
//
//  Created by Jasmine Panthee on 2/5/22.
//

import Foundation

class Series: NSObject, ObservableObject{
    @Published var N = 0
    
//    1       __ N        n   n
//   S   =   \      ( - 1)  -----
//    N      /__ 1          n + 1

    
    func calculate_S1(N:Int) -> Double{
        
    var sum1 = 0.0
       for i in (1...N){
           
           let sign = (-1.0)↑Double(i)
           let numerator = sign * Double(i)
           
           let denominator = Double(i)+1
           
           sum1 += (numerator/denominator)
           
       }
       
       return sum1
       
   }
    
    
//    2          __ N  2n - 1       __ N   2n
//   S   =   -  \      ------  +   \     ------
//    N         /__ 1    2n        /__ 1 2n + 1


    func calculate_S2(N:Int) -> Double{
        
    var sum2    = 0.0
    var subSum1 = 0.0
    var subSum2 = 0.0
    
       
       for i in (1...N){
           
           
           let numerator1   = 2*Double(i)-1.0
           let denominator1 = 2*Double(i)
           
           let numerator2   = 2*Double(i)
           let denominator2 = 2*Double(i)+1.0
           
           subSum1 = (-numerator1/denominator1)
           subSum2 = (numerator2/denominator2)
           
           sum2 += subSum1 + subSum2
           
       }
       
       return sum2
       
   }

    
//    3          __ N       1
//   S   =   -  \      ----------
//    N         /__ 1  2n(2n + 1)
    func calculate_S3(N:Int) -> Double{
        
    var sum3 = 0.0
       
       for i in (1...N){
           
           
           let numerator = 1.0
           
           let denominator = 2*Double(i)*(2*Double(i)+1)
           
           sum3 += (numerator/denominator)
           
       }
       
       return sum3
       
   }
    
//    up          __ N  1
//   S    =      \      -
//               /__ 1  n

    
    func calculate_Sup(N:Int) -> Double{
        
    var sumUp = 0.0
       
       for i in (1...N){
           
           
           let numerator = 1.0
           
           let denominator = Double(i)
           
           sumUp += (numerator/denominator)
           
       }
       
       return sumUp
       
   }
    
    
//    down      __ 1  1
//   S      =  \      -
//             /__ N  n

    
    func calculate_SDown(N:Int) -> Double{
        
    var sumDown = 0.0
    var j = N
       for _ in (1...N-1){
           j = j - 1
           
           let numerator = 1.0
           
           let denominator = Double(j)
           
           sumDown += (numerator/denominator)
           
       }
       
       return sumDown
       
   }
    
}
