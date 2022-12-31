//
//  NumberBoxView.swift
//  SwiftUIAlgorithms
//
//  Created by Cesar Mejia Valero on 12/31/22.
//

import SwiftUI

struct NumberBoxView: View {
    let number: String
    let color: Color
    let boxSize: BoxSize
    
    enum BoxSize: Double {
        case large = 60
        case small = 30
    }
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.gradient)
                    .frame(height: boxSize.rawValue)
                    .frame(minWidth: boxSize.rawValue / 2, maxWidth: boxSize.rawValue)
                    .shadow(radius: 3)
                
                Text(number)
                    .foregroundColor(.black.opacity(0.65))
                    .font(boxSize == .large ? .largeTitle.bold() : .headline)
            }
        }

    }
}

struct NumberBoxView_Previews: PreviewProvider {
    static var previews: some View {
        NumberBoxView(number: "1", color: .green, boxSize: .large)
            .previewLayout(.sizeThatFits)
    }
}
