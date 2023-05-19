//
//  InfoUserViewModel.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import Foundation

protocol InfoUserViewModelDelegate: ViewModelViewDelegate {
    func receivedData(info: InfoUserModel)
}

final class InfoUserViewModel {
    
    //MARK: - Properties
    let appService = AppService()
    weak var viewDelegate: InfoUserViewModelDelegate?
    var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    func getUserRepoUrl() -> String {
        return self.user.repos_url ?? ""
    }
    
    func fetchData() {
        self.viewDelegate?.set(loading: true)
        appService.fetchDataInfoUser(userURL: user.login) { result in
            self.viewDelegate?.set(loading: false)
            switch result {
            case .success(let model):
                print("Dados recebidos: \(model)")
                self.viewDelegate?.receivedData(info: model)
            case .failure(let error):
                // lide com o erro
                print("Erro ocorrido: \(error)")
            }
        }
        
    }
   
}
