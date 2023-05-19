//
//  UsersViewModel.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import Foundation

protocol UsersViewModelViewDelegate: ViewModelViewDelegate {
    func receivedData()
}

final class UsersViewModel {
    
    //MARK: - Properties
    let appService = AppService()
    weak var viewDelegate: UsersViewModelViewDelegate?
    private (set) var dataSreen: [User]?
    
    func numberOfRows() -> Int {
        return dataSreen?.count ?? 0
    }
    
    func getUserRow(indexPath: IndexPath) -> User? {
        let user = dataSreen?[indexPath.row]
        return user
    }
    
   
    func fetchSomeData() {
        self.viewDelegate?.set(loading: true)
        appService.fetchDataUsers { result in
            self.viewDelegate?.set(loading: false)
            switch result {
            case .success(let model):
                print("Dados recebidos: \(model)")
                self.dataSreen = model
                self.viewDelegate?.receivedData()
            case .failure(let error):
                // lide com o erro
                print("Erro ocorrido: \(error)")
                
            }
        }
    }
}
