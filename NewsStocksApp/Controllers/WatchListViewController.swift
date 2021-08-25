//
//  ViewController.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit

class WatchListViewController: UIViewController {
  
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSerchController()
        setupTitleView()
        
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

}

extension WatchListViewController:  UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultVC = searchController.searchResultsController as?
                SearchResultViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            return
        }
        print(query)
    }
    
    
    
}


extension WatchListViewController: SearchResultViewControllerDelegate {
    
    func searchResultViewControllerDidSelect(searchResult: SResult) {
       
    }
  
    
    
    
}
