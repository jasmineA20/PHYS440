//
//  Band_Structure.swift
//  BandStructuresAnd_PseudopotentialFormFactors
//
//  Created by Jasmine Panthee on 4/1/22.
//

//Calculates the Eigenvalues of the Hamiltonian taken from matrix manipulation file in github
import Foundation
import Accelerate

class BandStructure:ObservableObject{
    
        func calculateEigenvalues(arrayForDiagonalization: [Double]) -> String {
                var returnString = ""
                
                var N = Int32(sqrt(Double(arrayForDiagonalization.count)))
                var N2 = Int32(sqrt(Double(arrayForDiagonalization.count)))
                var N3 = Int32(sqrt(Double(arrayForDiagonalization.count)))
                var N4 = Int32(sqrt(Double(arrayForDiagonalization.count)))
                
                var flatArray = arrayForDiagonalization
                
                var error : Int32 = 0
                var lwork = Int32(-1)
                // Real parts of eigenvalues
                var wr = [Double](repeating: 0.0, count: Int(N))
                // Imaginary parts of eigenvalues
                var wi = [Double](repeating: 0.0, count: Int(N))
                // Left eigenvectors
                var vl = [Double](repeating: 0.0, count: Int(N*N))
                // Right eigenvectors
                var vr = [Double](repeating: 0.0, count: Int(N*N))
                
                
                var workspaceQuery: Double = 0.0
                dgeev_(UnsafeMutablePointer(mutating: ("N" as NSString).utf8String), UnsafeMutablePointer(mutating: ("V" as NSString).utf8String), &N, &flatArray, &N2, &wr, &wi, &vl, &N3, &vr, &N4, &workspaceQuery, &lwork, &error)
                
                print("Workspace Query \(workspaceQuery)")

                var workspace = [Double](repeating: 0.0, count: Int(workspaceQuery))
                lwork = Int32(workspaceQuery)
                

                dgeev_(UnsafeMutablePointer(mutating: ("N" as NSString).utf8String), UnsafeMutablePointer(mutating: ("V" as NSString).utf8String), &N, &flatArray, &N2, &wr, &wi, &vl, &N3, &vr, &N4, &workspace, &lwork, &error)
                
                
                if (error == 0)
                {
                    for index in 0..<wi.count      /* transform the returned matrices to eigenvalues and eigenvectors */
                    {
                        if (wi[index]>=0.0)
                        {
                            returnString += "Eigenvalue\n\(wr[index]) + \(wi[index])i\n\n"
                        }
                        else
                        {
                            returnString += "Eigenvalue\n\(wr[index]) - \(fabs(wi[index]))i\n\n"
                        }
                        
                        returnString += "Eigenvector\n"
                        returnString += "["
                        
                        for j in 0..<N
                        {
                            if(wi[index]==0)
                            {
                                
                                returnString += "\(vr[Int(index)*(Int(N))+Int(j)]) + 0.0i, \n" /* print x */
                                
                            }
                            else if(wi[index]>0)
                            {
                                if(vr[Int(index)*(Int(N))+Int(j)+Int(N)]>=0)
                                {
                                    returnString += "\(vr[Int(index)*(Int(N))+Int(j)]) + \(vr[Int(index)*(Int(N))+Int(j)+Int(N)])i, \n"
                                }
                                else
                                {
                                    returnString += "\(vr[Int(index)*(Int(N))+Int(j)]) - \(fabs(vr[Int(index)*(Int(N))+Int(j)+Int(N)]))i, \n"
                                }
                            }
                            else
                            {
                                if(vr[Int(index)*(Int(N))+Int(j)]>0)
                                {
                                    returnString += "\(vr[Int(index)*(Int(N))+Int(j)-Int(N)]) - \(vr[Int(index)*(Int(N))+Int(j)])i, \n"
                                    
                                }
                                else
                                {
                                    returnString += "\(vr[Int(index)*(Int(N))+Int(j)-Int(N)]) + \(fabs(vr[Int(index)*(Int(N))+Int(j)]))i, \n"
                                    
                                }
                            }
                        }
                        
                        /* Remove the last , in the returned Eigenvector */
                        returnString.remove(at: returnString.index(before: returnString.endIndex))
                        returnString.remove(at: returnString.index(before: returnString.endIndex))
                        returnString.remove(at: returnString.index(before: returnString.endIndex))
                        returnString += "]\n\n"
                    }
                }
                else {print("An error occurred\n")}
                
                return (returnString)
            }
    
}
