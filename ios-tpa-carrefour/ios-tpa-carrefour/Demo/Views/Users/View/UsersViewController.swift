//
//  UsersViewController.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import UIKit

class UsersViewController: BaseViewController {
  
    //MARK: - Properties
    private let viewModel: UsersViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.separatorStyle = .singleLine
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDelegate = self
        self.viewModel.fetchSomeData()
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        tableView.register(UserViewTablewCell.self, forCellReuseIdentifier: UserViewTablewCell  .identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = self.viewModel.getUserRow(indexPath: indexPath) else { return .init() }
        let cell = tableView.dequeueReusableCell(withIdentifier: UserViewTablewCell.identifier, for: indexPath) as! UserViewTablewCell
        cell.configure(with: user)
        cell.delegate = self
        return cell
    }
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = self.viewModel.getUserRow(indexPath: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        print("User \(user.login) selected")
    }

}

extension UsersViewController: UsersViewModelViewDelegate {
    func receivedData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension UsersViewController: UserViewTableViewCellDelegate {
    func didTapCell(user: User) {
         let infoUserViewModel = InfoUserViewModel(user)
         let viewController =  InforUserViewController(viewModel: infoUserViewModel)
        viewController.title = "Informações"
         navigationController?.pushViewController(viewController, animated: true)
    }
}
