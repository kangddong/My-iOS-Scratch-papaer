//
//  AudioVisualizerViewModel.swift
//  ExVoiceWave
//
//  Created by 강동영 on 5/20/25.
//


import AVFoundation
import Combine

final class AudioVisualizerViewModel: ObservableObject {
    private let audioEngine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private var cancellables = Set<AnyCancellable>()

    @Published var amplitudes: [Float] = Array(repeating: 0, count: 20)

    func startPlaying() {
        guard let url = Bundle.main.url(forResource: "Bass_Synth", withExtension: "mp3") else { return }

        do {
            let audioFile = try AVAudioFile(forReading: url)

            audioEngine.attach(playerNode)
            audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)

            // Tap for amplitude data
            audioEngine.mainMixerNode.installTap(onBus: 0, bufferSize: 512, format: audioFile.processingFormat) { [weak self] buffer, _ in
                guard let self = self else { return }
                self.updateAmplitudes(from: buffer)
            }

            try audioEngine.start()
            playerNode.scheduleFile(audioFile, at: nil)
            playerNode.play()

        } catch {
            print("Audio error: \(error)")
        }
    }

    func stopPlaying() {
        playerNode.stop()
        audioEngine.stop()
        audioEngine.mainMixerNode.removeTap(onBus: 0)
    }

    private func updateAmplitudes(from buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData?[0] else { return }

        let frameLength = Int(buffer.frameLength)
        let samples = stride(from: 0, to: frameLength, by: frameLength / amplitudes.count).map { i in
            abs(channelData[i])
        }

        DispatchQueue.main.async {
            self.amplitudes = samples
        }
    }
}
