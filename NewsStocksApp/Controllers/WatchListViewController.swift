//
//  ViewController.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit

class WatchListViewController: UIViewController, SearchResultViewControllerDelegate,
                               UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("ff")
    }
    
    func searchResultViewControllerDidSelect(searchResult: SResult) {
        print("pp")
    }
  

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSerchController()
        
        
    }
    
    private func setUpSerchController(){
            let resultVC = SearchResultViewController()
            resultVC.delegate = self
            let searchVC = UISearchController(searchResultsController: resultVC)
            searchVC.searchResultsUpdater = self
            navigationItem.searchController = searchVC
        }

}

