import AVKit
import AVFoundation
import UIKit

class ViewController: UIViewController {
    var queuePlayer: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Observe app becoming active
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let path = Bundle.main.path(forResource: "demo", ofType: "mp4") else {
            print("Video not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)

        queuePlayer = AVQueuePlayer()
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: item)

        let layer = AVPlayerLayer(player: queuePlayer)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)

        queuePlayer?.play()
    }

    @objc func appDidBecomeActive() {
        queuePlayer?.play()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

