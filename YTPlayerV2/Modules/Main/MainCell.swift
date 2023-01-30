//
//  MainCell.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 30.01.2023.
//

import UIKit
import SnapKit

class MainCell: UITableViewCell {
    
    static let identifier = "MainCell"
    
    
    
    var cellImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .brown.withAlphaComponent(0.4)
        imageView.image = UIImage(named: "banan")
        return imageView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
        addSubviews()
        setupConstraints()
    }
    
    
    private func setupCell() {
        self.backgroundColor = .purple
        
    }
    
    //MARK: Add Subviews
    private func addSubviews() {
        self.addSubview(cellImageView)
        
        setupConstraints()
    }
    
    //MARK: Setup Constraints
    private func setupConstraints() {
        cellImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self)
            
        }
    }
    
}

