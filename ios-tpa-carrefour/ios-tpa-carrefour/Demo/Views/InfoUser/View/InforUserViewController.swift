//
//  InforUserViewController.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import UIKit

class InforUserViewController: BaseViewController {
    
    //MARK: - Properties
    private let viewModel: InfoUserViewModel
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var button: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver Repositorio", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(nextEvent), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var stackViewName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var stackViewCompany: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = "Nome:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var nameFild: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var company: UILabel = {
        let label = UILabel()
        label.text = "Compania:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var companyFild: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
 
    init(viewModel: InfoUserViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDelegate = self
        self.viewModel.fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func nextEvent() {
        let reposityUsersViewModel = ReposityUsersViewModel(self.viewModel.getUserRepoUrl())
        let viewController = ReposityUsersViewController(reposityUsersViewModel)
        viewController.title = "Lista de Repositórios"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(userImageView)
        view.addSubview(stackViewMain)
        stackViewMain.addArrangedSubview(stackViewName)
        stackViewName.addArrangedSubview(name)
        stackViewName.addArrangedSubview(nameFild)
        stackViewMain.addArrangedSubview(stackViewCompany)
        stackViewCompany.addArrangedSubview(company)
        stackViewCompany.addArrangedSubview(companyFild)
        
        view.addSubview(button)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            stackViewMain.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 0),
            stackViewMain.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackViewMain.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            button.topAnchor.constraint(equalTo: stackViewMain.topAnchor, constant: 40),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
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

extension InforUserViewController: InfoUserViewModelDelegate {
    func receivedData(info: InfoUserModel) {
        DispatchQueue.main.async {
            self.nameFild.text = info.name
            self.companyFild.text = info.company
            self.loadImage(from: info.avatar_url)
        }
    }
}
