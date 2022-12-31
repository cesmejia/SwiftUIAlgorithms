//
//  TwoSumSolution.swift
//  SwiftUIAlgorithms
//
//  Created by Cesar Mejia Valero on 12/30/22.
//

struct SolutionAlgo {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var seenDict = [Int: Int]()
        
        for (currentIndex, currentNum) in nums.enumerated() {
            let desiredResult = target - currentNum
            if let foundIndex = seenDict[desiredResult] {
                return [foundIndex, currentIndex]
            }
            seenDict[currentNum] = currentIndex
        }
        
        return []
    }
}
