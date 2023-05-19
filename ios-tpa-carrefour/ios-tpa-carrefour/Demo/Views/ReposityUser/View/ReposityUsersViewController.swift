//
//  ReposityUsersViewController.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//
import UIKit

class ReposityUsersViewController: BaseViewController {
  
    //MARK: - Properties
    private let viewModel: ReposityUsersViewModel
    
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
        tableView.register(ReposityUsersViewTableCell.self, forCellReuseIdentifier: ReposityUsersViewTableCell  .identifier)
        return tableView
    }()
    
    init(_ viewModel: ReposityUsersViewModel) {
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
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ReposityUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reposityUserModel = self.viewModel.getDataRow(indexPath: indexPath) else { return .init() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposityUsersViewTableCell.identifier, for: indexPath) as! ReposityUsersViewTableCell
        cell.configure(with: reposityUserModel)
        return cell
    }
}

extension ReposityUsersViewController: ReposityUsersViewModelDelegate {
    func receivedData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
