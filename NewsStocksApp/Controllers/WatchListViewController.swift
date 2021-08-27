//
//  ViewController.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit
import FloatingPanel

class WatchListViewController: UIViewController {
  
    

    
    
    
    private var searchTimer: Timer?
    private var panel: FloatingPanelController?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSerchController()
        setupTitleView()
        setUpFlotingPanel()
        
    }
    
    
    private func setupTitleView() {
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0,
                                                     width: view.width,
                                                     height: navigationController?.navigationBar.height ?? 100 ))
                
                titleView.backgroundColor = .systemBackground
                navigationItem.titleView = titleView
                
                let lable = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width - 40, height: titleView.height))
                lable.text = "Stocks News"
                lable.font = .systemFont(ofSize: 32, weight: .medium)
                titleView.addSubview(lable)
        
    }
    
    
    
    private func setUpSerchController(){
            let resultVC = SearchResultViewController()
            resultVC.delegate = self
            let searchVC = UISearchController(searchResultsController: resultVC)
            searchVC.searchResultsUpdater = self
            navigationItem.searchController = searchVC
        }
    
    
    
    
    private func setUpFlotingPanel() {
            let vc = NewsViewController()
            let panels = FloatingPanelController(delegate: self)
            panels.surfaceView.backgroundColor = .secondarySystemBackground
            panels.set(contentViewController: vc)
//            panels.track(scrollView: vc)
            panels.addPanel(toParent: self)
           
     
        }
        
    
    
    
    
    
    
    

}

extension WatchListViewController: UISearchResultsUpdating {
    
    
  

    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultViewController,
              
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
//        reset timer
        searchTimer?.invalidate()
        
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            
            APIBase.shared.search(query: query) { result  in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        resultsVC.update(with: response.result)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        resultsVC.update(with: [])
                    }
                print(error)
                }
            }
            
        })
        
        
//        call out api here
//        resultsVC.update(with: ["foo"])
        
        
    }
    
    
    
    
}


extension WatchListViewController: SearchResultViewControllerDelegate {
    
    func searchResultViewControllerDidSelect(searchResult: SResult) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
                
                let vc = StockDetailsViewController()
//        (symbol: searchResult.symbol,
//                                            companyName: searchResult.description,
//                                            candleStickData: [])
        
        
                let navVC = UINavigationController(rootViewController: vc)
                vc.title = searchResult.description
                present(navVC, animated: true)
    }
  
    
    
    
}


extension WatchListViewController: FloatingPanelControllerDelegate {
    
    
    
    func floatingPanelDidChangePosition(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
    
}

