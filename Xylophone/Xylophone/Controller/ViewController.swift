//
//  ViewController.swift
//  Xylophone
//
//  Created by chihoooon on 2021/11/03.
//

import UIKit
import SnapKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer?
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpXylophone()
    }
    
    private func setUpXylophone() {
        mainView.delegate = self
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func playSound(_ title: String) {
        guard let url = Bundle.main.url(forResource: title, withExtension: "wav") else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: MainViewDelegate {
    func keyPressed(_ button: UIButton) {
        guard let title = button.titleLabel?.text else {
            return
        }
        playSound(title)
    }
}
