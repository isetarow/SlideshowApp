//
//  ScaleImageViewController.swift
//  SlideshowApp
//
//  Created by 吉田　一誠 on 2021/08/26.
//

import UIKit

class ScaleImageViewController: UIViewController {
    @IBOutlet weak var scaledImageView: UIImageView!
    var scaledImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scaledImageView.image = scaledImage!
    }

}
