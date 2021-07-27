//
//  PhotoViewerViewController.swift
//  Messenger
//
//  Created by chihoooon on 2021/07/12.
//

import UIKit
import SDWebImage

class PhotoViewerViewController: UIViewController {

    private let url: URL
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        imageView.backgroundColor = .black
        imageView.sd_setImage(with: self.url, completed: nil)
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
    }
    
    init(with url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
