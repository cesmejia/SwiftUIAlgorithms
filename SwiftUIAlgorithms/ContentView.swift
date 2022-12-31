//
//  ContentView.swift
//  SwiftUIAlgorithms
//
//  Created by Cesar Mejia Valero on 12/30/22.
//

import SwiftUI

struct ContentView: View {
    let numbers = [3, 5, 2, -4, 8, 11]
    let target = 7
    
    @State private var seenDictionary = [Int: Int]()
    @State private var currentIndex = -1
    @State private var currentNumber = 0
    @State private var lookingForNumber = 0
    
    @State private var algoStatus: AlgoStatus = .idle
    @State private var showFinishedAlert = false
    
    @State private var result = [Int]()
    
    enum AlgoStatus {
        case idle, started
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    Text("Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target. You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order.")
                        .padding(.bottom)
                    Text("Numbers:")
                        .font(.title)
                    HStack {
                        ForEach(Array(zip(numbers.indices, numbers)), id: \.0) { index, number in
                            VStack {
                                NumberBoxView(number: "\(number)", color: algoStatus != .idle && currentIndex == index ? .green : .yellow, boxSize: .large)
                                NumberBoxView(number: "\(index)", color: algoStatus != .idle && currentIndex == index ? .blue : .gray, boxSize: .small)
                            }
                        }
                    }
                    Text("Target: \(target)")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                }
                Text("Seen dictionary: \(seenDictionary.description)")
                    .font(.headline)
                Text(algoStatus == .idle ? "Current index: -" : "Current index: \(currentIndex)")
                    .font(.headline)
                Text(algoStatus == .idle ? "Current number: -" : "Current number: \(currentNumber)")
                    .font(.headline)
                Text(algoStatus == .idle ? "Currently looking number: -" : "Currently looking number: \(lookingForNumber)")
                    .font(.headline)
                Text("Result: \(result.description)")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Spacer()
                Button(algoStatus == .idle ? "Start" : "Next") {
                    algoStatus = .started
                    currentIndex += 1
                    currentNumber = numbers[currentIndex]
                    lookingForNumber = target - currentNumber
                    
                    if let foundIndex = seenDictionary[lookingForNumber] {
                        result = [foundIndex, currentIndex]
                        showFinishedAlert = true
                    }
                    seenDictionary[currentNumber] = currentIndex
                }
                .font(.largeTitle)
            }
            .padding()
            .navigationTitle("Two Sum")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
