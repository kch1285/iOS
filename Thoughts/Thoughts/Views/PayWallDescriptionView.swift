//
//  PayWallDescriptionView.swift
//  Thoughts
//
//  Created by chihoooon on 2021/08/13.
//

import UIKit

class PayWallDescriptionView: UIView {
    
    private let descriptorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.numberOfLines = 0
        label.text = "프리미엄 구독권을 구입하면 더 좋아요"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 1
        label.text = "5000원 / 달"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(descriptorLabel)
        addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptorLabel.frame = CGRect(x: 20, y: 0, width: width - 40, height: height / 2)
        priceLabel.frame = CGRect(x: 20, y: height / 2, width: width - 40, height: height / 2)
    }
}
