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
    static var maxWidth: CGFloat = 0
    private var viewModels: [WatchllistTableViewCell.viewModel] = []
    private var watchlistMap: [String: [CandleStick]] = [:]
    
    //   MARK: - lifecycle
       private lazy var tableView: UITableView = {
           let table = UITableView()
           table.register(WatchllistTableViewCell.self,
                          forCellReuseIdentifier: WatchllistTableViewCell.identifier)
           return table
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSerchController()
        setupTitleView()
        setUpTableView()
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
    
    
    
    
    private func setUpTableView() {
           view.addSubviews(tableView)
           tableView.frame = view.bounds
           tableView.delegate = self
           tableView.dataSource = self
       }
       
    
    
    
    
    
    
    private func setUpFlotingPanel() {
        let vc = NewsViewController(type: .topStories)
           let panels = FloatingPanelController(delegate: self)
           panels.surfaceView.backgroundColor = .secondarySystemBackground
           panels.set(contentViewController: vc)
           panels.track(scrollView: vc.tableView)
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
                
        let vc = StockDetailsViewController(symbol: searchResult.symbol,
                                            companyName: searchResult.description,
                                            candleStickData: [])
   
                let navVC = UINavigationController(rootViewController: vc)
                vc.title = searchResult.description
                present(navVC, animated: true)
    }
  
    
    
    
}


extension WatchListViewController: FloatingPanelControllerDelegate {
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
    
//    func floatingPanelDidChangePosition(_ fpc: FloatingPanelController) {
//        navigationItem.titleView?.isHidden = fpc.state == .full
//    }
    
}

// MARK: - TableView
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
 
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchllistTableViewCell.identifier,
                                                       for: indexPath) as? WatchllistTableViewCell else {
            
            fatalError()
            
        }
        
        cell.delegate = self
        cell.configure(with: viewModels[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WatchllistTableViewCell.prffHight
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            PManager.shared.removeFromWatchList(symbol: viewModels[indexPath.row].symbol)
            viewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        
        let viewModel = viewModels[indexPath.row]
        let vc = StockDetailsViewController(symbol: viewModel.symbol,
                                            companyName: viewModel.companyName,
                                            candleStickData: watchlistMap[viewModel.symbol] ?? [] )
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
        
        
    }
    
    
}

extension WatchListViewController: WatchllistTableViewCellDelegate {
    func didUpDateWidth() {
        tableView.reloadData()
    }
    
    
}
