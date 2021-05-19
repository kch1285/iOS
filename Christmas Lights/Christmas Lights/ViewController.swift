//
//  ViewController.swift
//  Christmas Lights
//
//  Created by chihoooon on 2021/05/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var holder: UIView!
    
    var onOffFlag: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCircles()
    }
    
    func setupCircles(){
        let circleSize: CGFloat = view.frame.size.width / 4
        
        for y in 0..<3{
            for x in 0..<3{
                let view = UIView(frame: CGRect(x: circleSize * CGFloat(x) + holder.frame.size.width / 16 * CGFloat(x + 1), y: holder.frame.size.height - (circleSize * CGFloat(6 - y)), width: circleSize, height: circleSize))
                view.layer.cornerRadius = circleSize / 2
                view.tag = 3 * y + x + 1
                view.bounds = view.frame.insetBy(dx: 10, dy: 10)
                
                if view.tag % 2 == 0{
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                        view.backgroundColor = .random()
                        view.layer.shadowColor = view.backgroundColor?.cgColor
                        view.layer.shadowRadius = 30
                        view.layer.shadowOpacity = 1
                        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
                    }, completion: nil)
                }
                else{
                    UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat, .autoreverse], animations: {
                        view.backgroundColor = .random()
                        view.layer.shadowColor = view.backgroundColor?.cgColor
                        view.layer.shadowRadius = 30
                        view.layer.shadowOpacity = 1
                        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
                        
                    }, completion: nil)
                }
                
                holder.addSubview(view)
            }
        }
        
        let onAndOffButton = UIButton(frame: CGRect(x: circleSize * 1.5, y: circleSize * 0.2, width: circleSize, height: circleSize))
        onAndOffButton.setTitle("On / Off", for: .normal)
        onAndOffButton.layer.cornerRadius = circleSize / 2
        onAndOffButton.backgroundColor = .white
        onAndOffButton.setTitleColor(.black, for: .normal)
        onAndOffButton.addTarget(self, action: #selector(onPressed(_:)), for: .touchUpInside)
        holder.addSubview(onAndOffButton)
        
        let speedLabel = UILabel(frame: CGRect(x: circleSize, y: circleSize * 1.3, width: circleSize, height: circleSize / 2))
        speedLabel.text = "Speed : "
        speedLabel.textAlignment = .center
        speedLabel.font = UIFont.systemFont(ofSize: 20)
        speedLabel.textColor = .yellow
        holder.addSubview(speedLabel)
        
        let speedText = UITextField(frame: CGRect(x: circleSize * 2, y: circleSize * 1.3, width: circleSize * 0.6, height: circleSize / 2))
        speedText.layer.cornerRadius = speedText.frame.height / 2
        speedText.placeholder = "1 ~ 5"
        speedText.textAlignment = .center
        speedText.backgroundColor = .white
        speedText.keyboardType = .decimalPad
        speedText.tag = 1
        speedText.endEditing(true)
        holder.addSubview(speedText)
        
        let setButton = UIButton(frame: CGRect(x: circleSize * 2.7, y: circleSize * 1.3, width: circleSize / 2, height: circleSize / 2))
        setButton.setTitle("Set", for: .normal)
        setButton.backgroundColor = .blue
        setButton.layer.cornerRadius = setButton.frame.height / 2
        setButton.setTitleColor(.yellow, for: .normal)
        setButton.addTarget(self, action: #selector(setPressed(_:)), for: .touchUpInside)
        holder.addSubview(setButton)
    }
    
    @objc func setPressed(_ sender: UIButton){
        if !onOffFlag{
            
        }
    }
    
    @objc func onPressed(_ sender: UIButton){
        if onOffFlag{
            for x in 1...9{
                let view = self.view.viewWithTag(x)
                view?.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
                view?.layer.shadowOpacity = 0
            }
            onOffFlag = false
        }
        else{
            for x in 1...9{
                let view = self.view.viewWithTag(x)
                view?.backgroundColor = .random()
                if x % 2 == 0{
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                        view?.layer.shadowColor = view?.backgroundColor?.cgColor
                        view?.layer.shadowRadius = 30
                        view?.layer.shadowOpacity = 1
                        view?.layer.shadowPath = UIBezierPath(rect: view!.bounds).cgPath
                    }, completion: nil)
                }
                else{
                    UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat, .autoreverse], animations: {
                        view?.layer.shadowColor = view?.backgroundColor?.cgColor
                        view?.layer.shadowRadius = 30
                        view?.layer.shadowOpacity = 1
                        view?.layer.shadowPath = UIBezierPath(rect: view!.bounds).cgPath
                        
                    }, completion: nil)
                }
                
            }
            onOffFlag = true
        }
        
        
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1
        )
    }
}
