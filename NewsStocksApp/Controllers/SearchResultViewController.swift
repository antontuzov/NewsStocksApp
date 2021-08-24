//
//  SearchResultViewController.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidSelect(searchResult: SResult)
  
}


class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    weak var delegate: SearchResultViewControllerDelegate?

    
    
    private var results: [SResult] = []
    
  private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self,
                       forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    
    
    public func update(with result: [SResult]){
        self.results = result
        tableView.isHidden = result.isEmpty
        tableView.reloadData()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                 for: indexPath)
        
        
        let model = results[indexPath.row]
        
        cell.textLabel?.text = model.displaySymbol
//        error here work on it!!
        cell.detailTextLabel?.text = model.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = results[indexPath.row]
        delegate?.searchResultViewControllerDidSelect(searchResult: model)
    }


}
