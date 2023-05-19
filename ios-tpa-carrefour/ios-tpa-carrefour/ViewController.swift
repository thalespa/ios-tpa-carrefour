//
//  ViewController.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

            // 1. Configurar a cor de fundo da view
            view.backgroundColor = .white

            // 2. Criar e configurar uma subview
            let myLabel = UILabel()
            myLabel.text = "Olá, Mundo!"
            myLabel.translatesAutoresizingMaskIntoConstraints = false

            // 3. Adicionar a subview à view do ViewController
            view.addSubview(myLabel)

            // 4. Configurar restrições da subview
            NSLayoutConstraint.activate([
                myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

