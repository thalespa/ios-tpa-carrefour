//
//  UserViewTablewCell.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import UIKit

protocol UserViewTableViewCellDelegate: AnyObject {
    func didTapCell(user: User)
}

class UserViewTablewCell: UITableViewCell {
    
    weak var delegate: UserViewTableViewCellDelegate?
    static let identifier = "UserCell"
    private var userCurrente: User?
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        self.addGestureRecognizer(tapGesture)
        
        setupSubViews()
    }
    
    @objc private func didTapCell() {
        guard let user = userCurrente else { return }
        delegate?.didTapCell(user: user)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupSubViews() {
        contentView.addSubview(loginLabel)
        contentView.addSubview(userImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
                       
            loginLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            loginLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with user: User) {
        self.userCurrente = user
        loginLabel.text = user.login
        loadImage(from: user.avatar_url)
    }
    
    private func loadImage(from url: String?) {
        guard let url = url else { return  }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: url)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                            self?.userImageView.image = image
                    }
                }
            }
        }
    }
}
