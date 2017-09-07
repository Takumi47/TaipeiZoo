//
//  ImageViewController.swift
//  TaipeiZoo
//
//  Created by alex on 06/09/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ImageViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Properties
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 1.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    fileprivate var imageView = UIImageView()
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            stopAnimating()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
}

// MARK: - UIScrollViewDelegate

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
