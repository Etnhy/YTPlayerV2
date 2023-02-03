//
//  YTPLayerViewController.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit

class YTPLayerViewController: UIViewController {
    static let identifier = "YTPLayerViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
    }
    
    fileprivate func settings() {
        self.view.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: self.view.frame.width,height: 700))
        }
        self.view.layer.cornerRadius = 40

        
    }

}
