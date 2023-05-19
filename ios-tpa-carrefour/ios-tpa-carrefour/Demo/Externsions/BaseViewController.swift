//
//  BaseViewController.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import UIKit

protocol ViewModelViewDelegate: AnyObject {
    func set(loading: Bool)
}

extension ViewModelViewDelegate where Self: BaseViewController {
    func set(loading: Bool) {
        loading ? self.showLoading() : self.hideLoading()
    }
}

class BaseViewController: UIViewController {
   
    private var loadView: UIView?
   
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func showLoading() {
        self.loadView?.removeFromSuperview()
       
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
           
       loadView = UIView(frame: window.bounds)
       loadView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
               
       let activityIndicator = UIActivityIndicatorView(style: .large)
       activityIndicator.center = loadView!.center
       activityIndicator.startAnimating()
               
       loadView?.addSubview(activityIndicator)
       window.addSubview(loadView!)
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadView?.removeFromSuperview()
            self.loadView = nil
        }
    }
}
