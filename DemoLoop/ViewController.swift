import AVKit
import AVFoundation
import UIKit

class ViewController: UIViewController {
    var queuePlayer: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let path = Bundle.main.path(forResource: "demo", ofType: "mp4") else {
            print("Video not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)

        // Setup looping player
        queuePlayer = AVQueuePlayer()
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: item)

        let layer = AVPlayerLayer(player: queuePlayer)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)

        queuePlayer?.play()
    }
}
