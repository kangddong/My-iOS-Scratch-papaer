//
//  AudioVisualizerView.swift
//  ExVoiceWave
//
//  Created by 강동영 on 5/20/25.
//


import SwiftUI

struct AudioVisualizerView: View {
    @StateObject private var viewModel = AudioVisualizerViewModel()

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center, spacing: 4) {
                ForEach(viewModel.amplitudes, id: \.self) { amp in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.blue)
                        .frame(width: 4, height: max(2, CGFloat(amp) * 150))
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 160)

            Button("▶︎ Play") {
                viewModel.startPlaying()
            }
            .padding()

            Button("■ Stop") {
                viewModel.stopPlaying()
            }
            .padding(.bottom)
        }
    }
}
