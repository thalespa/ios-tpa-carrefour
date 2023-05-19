//
//  ReposityUsersViewModel.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import Foundation

protocol ReposityUsersViewModelDelegate: ViewModelViewDelegate {
    func receivedData()
}

final class ReposityUsersViewModel {
    
    //MARK: - Properties
    let appService = AppService()
    weak var viewDelegate: ReposityUsersViewModelDelegate?
    private (set) var dataSreen: [ReposityUserModel]?
    var urlReposity: String
    
    init(_ urlReposity: String) {
        self.urlReposity = urlReposity
    }
    
    func numberOfRows() -> Int {
        return dataSreen?.count ?? 0
    }
    
    func getDataRow(indexPath: IndexPath) -> ReposityUserModel? {
        let user = dataSreen?[indexPath.row]
        return user
    }
    
   
    func fetchSomeData() {
        self.viewDelegate?.set(loading: true)
        appService.fetchDataReposityUser(reposityURL: self.urlReposity) { result in
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
