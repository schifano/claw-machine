import AVFoundation

struct Sounds {
    
    static var melody: AVAudioPlayer?
    
    /// Configures the audio player
    static func setupAudio() {
        if let path = Bundle.main.path(forResource: "melody", ofType: "m4a") {
            let url = URL(fileURLWithPath: path)
            do {
                melody = try AVAudioPlayer(contentsOf: url)
                melody?.numberOfLoops = -1
                melody?.volume = 0.5
                melody?.prepareToPlay()
            } catch {
                print("Could not play melody") // DEBUG
            }
        }
    }
    
    /// Toggles playback for the audio
    static func playMelody() {
        guard let melody = Sounds.melody else {
            print("No audio was set up") // DEBUG
            return
        }
        melody.play()
    }
    
    /// Pauses the audio
    static func pauseMelody() {
        guard let melody = Sounds.melody else {
            print("No audio was set up") // DEBUG
            return
        }
        melody.pause()
        melody.currentTime = 0
    }
}

