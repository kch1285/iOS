//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {

    static let idenrifier = "IGFeedPostGeneralTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func configure() {
        
    }

}