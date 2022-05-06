/*
import Foundation

class Bands{
//Reciprocal Lattice Vector G
    //G^2 only has non-zero potential at 3, 4, 8, 11
    //G = b1*u + b2*v + b3*w  with u, v, w in range -2, -1, 0, 1, 2
    //creates a 125x125 matrix
    //states = 5 --> {-2, -1, 0, 1, 2}
    func makebands(){
        var b1:[Double] = [-1, 1, 1]
        
        var b2:[Double] = [1, -1, 1]
        
        var b3 :[Double] = [1, 1, -1]
        //How to go through all u, v, w values to get G for matrix?
        var states = 5
        //m is an increment that goes over all possible values of u, v, and w
            
            
        for m in stride(from: -2.0, through: 2.0, by: 0.5) {
            let n = floor(pow(Double(states), 3)/2)
            let s = m + n
            let flr = floor(Double(states)/2.0)
            let statesSqrd = pow(Double(states), 2.0)
            
            u = floor(s/Double(statesSqrd)) - flr
            v = s.truncatingRemainder(dividingBy:floor(Double(statesSqrd/(Double(states) - flr))))
            w = s.truncatingRemainder(dividingBy:(Double(states) - flr))
           // w = s%(Double(states) - flr)
            b1 = b1.map { $0 * u }
            b2 = b2.map { $0 * v }
            b3 = b3.map { $0 * w }
            var b12 = zip(b1, b2).map { $0 + $1 }
            var bValues = zip(b12, b3).map { $0 + $1 }
            G.append(bValues)
        }
    }
}

*/
