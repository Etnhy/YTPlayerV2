//
//  MainViewController.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 30.01.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var youtubeApiLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Youtube API"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    lazy var playlistTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(youtubeApiLabel)
        view.addSubview(playlistTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        youtubeApiLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaInsets.top).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        playlistTableView.snp.makeConstraints { make in
            make.top.equalTo(youtubeApiLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 300
        case 1: return 400
        default: return 163
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    
}
