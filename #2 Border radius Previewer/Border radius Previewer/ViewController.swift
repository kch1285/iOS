//
//  ViewController.swift
//  Border radius Previewer
//
//  Created by chihoooon on 2021/05/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtTopLeft: UITextField!
    @IBOutlet weak var txtTopRight: UITextField!
    @IBOutlet weak var txtBottomLeft: UITextField!
    @IBOutlet weak var txtBottomRight: UITextField!
    
    
    let preView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let topLeft = NumberFormatter().number(from: txtTopLeft.text ?? "0")  else{ return }
        guard let topRight = NumberFormatter().number(from: txtTopRight.text ?? "0")  else{ return }
        guard let bottomLeft = NumberFormatter().number(from: txtBottomLeft.text ?? "0")  else{ return }
        guard let bottomRight = NumberFormatter().number(from: txtBottomRight.text ?? "0")  else{ return }

        preView.roundCorners(topLeft: CGFloat(truncating: topLeft), topRight: CGFloat(truncating: topRight), bottomLeft: CGFloat(truncating: bottomLeft), bottomRight: CGFloat(truncating: bottomRight))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(preView)
        NSLayoutConstraint.activate([
            self.preView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.preView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            self.preView.widthAnchor.constraint(equalToConstant: 200),
            self.preView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        txtTopLeft.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtTopRight.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtBottomLeft.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtBottomRight.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIView {
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}



extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}
