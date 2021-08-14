//
//  ViewController.swift
//  QRCode
//
//  Created by chihoooon on 2021/08/14.
//

import UIKit
import WebKit
import AVFoundation
import QRCodeReader

class MainViewController: UIViewController {
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    private let webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let qrCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("QR코드 인식", for: .normal)
        button.tintColor = .secondaryLabel
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        let url = URL(string: "https://www.naver.com/")
        
        guard let url = url else {
            return
        }
        
        let requestObj = URLRequest(url: url)
        
        qrCodeButton.addTarget(self, action: #selector(didTapQRCodeButton), for: .touchUpInside)
        webView.load(requestObj)
        view.addSubview(webView)
        webView.addSubview(qrCodeButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        
        let buttonSize: CGFloat = view.frame.width / 2
        qrCodeButton.frame = CGRect(x: buttonSize / 2, y: view.frame.height - buttonSize, width: buttonSize, height: 70)
    }
    
    @objc private func didTapQRCodeButton() {
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            guard let scannedUrlString = result?.value, let scannedUrl = URL(string: scannedUrlString) else {
                return
            }
            
            self.webView.load(URLRequest(url: scannedUrl))
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        
        present(readerVC, animated: true, completion: nil)
    }

}

//MARK: - QRCodeReaderViewControllerDelegate
extension MainViewController: QRCodeReaderViewControllerDelegate {
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
}
