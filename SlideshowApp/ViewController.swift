//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 吉田　一誠 on 2021/08/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!
    ]
    
    var count = 0
    
    var timer: Timer!
    
    var isPlayingBeforeTransition: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage(0)
    }
    
    @IBAction func next(_ sender: Any) {
        self.count += 1
        setImage(self.count)
    }
    
    @IBAction func prev(_ sender: Any) {
        self.count -= 1
        setImage(self.count)
    }
    
    @IBAction func setTimer(_ sender: Any) {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateCount(_:)), userInfo: nil, repeats: true)
            setButtonEnabled(false)
            playButton.setTitle("停止", for: .normal)
        } else {
            self.timer.invalidate()
            self.timer = nil
            setButtonEnabled(true)
            playButton.setTitle("再生", for: .normal)
        }
    }
    
    @objc func updateCount(_ timer: Timer) {
        self.count += 1
        setImage(self.count)
    }
    
    func getImage(_ count: Int) -> UIImage {
        var imageIndex = count % images.count
        if (imageIndex < 0) {
            imageIndex = abs(imageIndex + images.count)
        }
        return images[imageIndex]
    }
    
    func setImage(_ count: Int) {
        imageView.image = getImage(count)
    }
    
    func setButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        prevButton.isEnabled = isEnabled
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        if self.isPlayingBeforeTransition {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateCount(_:)), userInfo: nil, repeats: true)
        }
        self.isPlayingBeforeTransition = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
            self.isPlayingBeforeTransition = true
        }
        
        let scaledImageViewController:ScaleImageViewController = segue.destination as! ScaleImageViewController
        scaledImageViewController.scaledImage = getImage(self.count)
    }
}

