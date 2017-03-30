import AVFoundation

struct Sounds {
    
    static var melody: AVAudioPlayer?
    
    static func setupAudio() {
        // Configure audio
        if let path = Bundle.main.path(forResource: "melody", ofType: "m4a") {
            let url = URL(fileURLWithPath: path)
            do {
                melody = try AVAudioPlayer(contentsOf: url)
                melody?.numberOfLoops = -1
                melody?.volume = 0.5
                melody?.prepareToPlay()
            } catch {
                print("Could not play melody")
            }
        }
    }
    
    static func playMelody() {
        guard let melody = Sounds.melody else {
            print("no audio was set up")
            return
        }
        melody.play()
    }
    
    static func pauseMelody() {
        guard let melody = Sounds.melody else {
            print("no audio was set up")
            return
        }
        melody.pause()
        melody.currentTime = 0
    }
}

