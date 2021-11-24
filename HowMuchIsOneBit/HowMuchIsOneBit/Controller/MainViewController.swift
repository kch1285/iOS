//
//  ViewController.swift
//  HowMuchIsOneBit
//
//  Created by chihoooon on 2021/11/24.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = MainView()
    private var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMainView()
        coinManager.delegate = self
    }

    private func setUpMainView() {
        view.addSubview(mainView)
        mainView.pickerView.dataSource = self
        mainView.pickerView.delegate = self
        
        mainView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

//MARK: - UIPickerViewDataSource
extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate
extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedUnit = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedUnit)
    }
}


extension MainViewController: CoinManagerDelegate {
    func didUpdatePrice(_ coin: CoinModel) {
        DispatchQueue.main.async {
            self.mainView.bitCoinValueLabel.text = String(format: "%.2f", coin.rate)
            self.mainView.unitLabel.text = coin.currency
        }
    }
}
