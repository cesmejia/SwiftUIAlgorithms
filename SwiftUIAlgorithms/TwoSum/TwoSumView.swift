//
//  TwoSumView.swift
//  SwiftUIAlgorithms
//
//  Created by Cesar Mejia Valero on 12/30/22.
//

import SwiftUI
import OrderedCollections

struct TwoSumView: View {
    let numbers = [3, 5, 2, -4, 8, 11]
    let target = 7
    
    @State private var seenDictionary: OrderedDictionary<Int, Int> = [:]
    @State private var currentIndex = -1
    @State private var currentNumber = 0
    @State private var lookingForNumber = 0
    
    @State private var algoStatus: AlgoStatus = .start
    @State private var showFinishedAlert = false
    
    @State private var result = [Int]()
    
    enum AlgoStatus {
        case start, playing, finished
    }
    
    private func getCurrentNumberBoxColor(for number: Int) -> Color {
        if algoStatus != .start && lookingForNumber == number && seenDictionary[lookingForNumber] != nil {
            return .green
        } else if algoStatus != .start && currentNumber == number {
            return .orange
        } else {
            return .yellow
        }
    }
    
    private func getCurrentIndexBoxColor(for index: Int) -> Color { // TODO: Check logic for index color
        if algoStatus != .start {
            if seenDictionary[lookingForNumber] != nil && currentIndex == index || seenDictionary[lookingForNumber] == index {
                return .green.opacity(0.5)
            } else if currentIndex == index {
                return .blue
            }
        }
        return .gray
    }
    
    private func getButtonText(for status: AlgoStatus) -> String {
        switch algoStatus{
        case .start:
            return "Start"
        case .playing:
            return "Next"
        case .finished:
            return "Restart"
        }
    }
    
    private func reset() {
        withAnimation {
            algoStatus = .start
            currentIndex = -1
            currentNumber = 0
            lookingForNumber = 0
            result = []
            seenDictionary = [:]
        }
    }
    
    private func nextStep() {
        withAnimation {
            algoStatus = .playing
            currentIndex += 1
            currentNumber = numbers[currentIndex]
            lookingForNumber = target - currentNumber
            
            if let foundIndex = seenDictionary[lookingForNumber] {
                result = [foundIndex, currentIndex]
//                showFinishedAlert = true
                algoStatus = .finished
            }
            seenDictionary[currentNumber] = currentIndex
        }
    }
    
    private func toNextAlgoStatus() {
        if algoStatus == .finished {
            reset()
        } else {
            nextStep()
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Group {
//                    Text("Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target. You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order.")
//                        .padding(.bottom)
                    Text("Numbers:")
                        .font(.title)
                    HStack {
                        ForEach(Array(zip(numbers.indices, numbers)), id: \.0) { index, number in
                            VStack {
                                NumberBoxView(number: "\(number)", color: getCurrentNumberBoxColor(for: number), boxSize: .large)
                                NumberBoxView(number: "\(index)", color: getCurrentIndexBoxColor(for: index), boxSize: .small)
                            }
                        }
                    }
                    Text("Target Sum: \(target)")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                }
                Text(algoStatus == .start ? "Currently looking for number: -" : "Currently looking for number: \(lookingForNumber)")
                    .font(.headline)
                Text("Result: \(result.description)")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Text("Seen dictionary:")
                    .font(.headline)
                VStack {
                    ForEach(Array(zip(seenDictionary.values, seenDictionary.keys)), id: \.0) { index, number in
                        HStack {
                            NumberBoxView(number: "\(number)", color: getCurrentNumberBoxColor(for: number), boxSize: .small)
                            Text(":")
                            NumberBoxView(number: "\(index)", color: getCurrentIndexBoxColor(for: index), boxSize: .small)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Two Sum")
            .background(.blue.gradient)
            .toolbar {
                Button(getButtonText(for: algoStatus)) {
                    toNextAlgoStatus()
                }
                .font(.title).bold()
                .foregroundColor(.orange)
            }
        }
    }
}

struct TwoSumView_Previews: PreviewProvider {
    static var previews: some View {
        TwoSumView()
    }
}
