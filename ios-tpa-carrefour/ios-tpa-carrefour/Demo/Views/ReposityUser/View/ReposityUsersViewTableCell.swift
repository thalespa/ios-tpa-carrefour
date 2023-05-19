//
//  UserViewTablewCell.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import UIKit

protocol ReposityUsersViewTableCellDelegate: AnyObject {
    func didTapCell(user: ReposityUserModel)
}

class ReposityUsersViewTableCell: UITableViewCell {
    
    weak var delegate: ReposityUsersViewTableCellDelegate?
    static let identifier = "ReposityUsersViewTableCell"

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelUrl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupSubViews() {
        contentView.addSubview(label)
        contentView.addSubview(labelUrl)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
           
            labelUrl.topAnchor.constraint(equalTo: label.bottomAnchor),
            labelUrl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            labelUrl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            labelUrl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -16)
            
            
        ])
    }
    
    func configure(with reposityUserModel: ReposityUserModel) {
        label.text = reposityUserModel.full_name
        labelUrl.text = reposityUserModel.html_url
    }
}
