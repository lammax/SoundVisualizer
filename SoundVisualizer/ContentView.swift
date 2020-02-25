//
//  ContentView.swift
//  SoundVisualizer
//
//  Created by Mac on 25.02.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI

let numberOfSamples: Int = 10

struct ContentView: View {
    // 1
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    
    // 2
    private func normalizeSoundLevel(_ level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    var body: some View {
        VStack {
            Text("\(normalizeSoundLevel(mic.soundSamples.max() ?? 0.0))")
             // 3
            HStack(spacing: 4) {
                 // 4
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level))
                }
            }
        }
    }
}

struct BarView: View {
   // 1
    var value: CGFloat

    var body: some View {
        ZStack {
           // 2
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                //.luminanceToAlpha()
                .opacity(0.5)
                // 3
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
        }
    }
}
