//
//  ViewController.swift
//  Bin2Dec
//
//  Created by chihoooon on 2021/05/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtBin: UITextField!
    @IBOutlet weak var btnCalculate: UIButton!
    @IBOutlet weak var lbNotify: UILabel!
    @IBOutlet weak var lbDecimal: UILabel!
    
    @IBAction func touchCalculateButton(_ sender: UIButton){
        guard let binNum = txtBin.text  else{ return }
        if binNum.count > 8{
            return
        }
        
        self.view.endEditing(true)
        if binNum.contains("0") && binNum.contains("1"){
            if let decimalNum = Int(binNum, radix: 2){
                lbDecimal.text = String(decimalNum)
            }
        }
        
        else{
            lbNotify.text = "User can enter only binary digits !"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

