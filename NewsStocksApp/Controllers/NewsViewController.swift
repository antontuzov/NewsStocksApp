//
//  NewsViewController.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit
import SafariServices


class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    enum `Type` {
        case topStories
        case compan(symbol: String)
        
        
        var title: String {
            switch self {
            case .topStories:
                return "Top Storises"
            case .compan(let symbol):
                return symbol.uppercased()
                
            }
           
        }
     
    }
    
    
    
    
    
    lazy var tableView: UITableView = {
        let table  = UITableView()

        table.register(NewsStoryTableViewCell.self, forCellReuseIdentifier: "NewsStoryTableViewCell")
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        table.backgroundColor = .clear
//        table.rowHeight = 120
        return table
    }()
    
    
    
    
// MARK: - Private
    
    
    private var stories = [NewsStory]()

    private let type: Type
 
    //    MARK: -init
    init(type: Type) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: -lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        fetchNews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    
    //    MARK: -Private
    
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func  fetchNews() {
        APIBase.shared.news(for: type) {[weak self] result in
            switch result {
            case .success(let stories):
                DispatchQueue.main.async {
                    self?.stories = stories
                    self?.tableView.reloadData()
                }
            case .failure(let error):
            print(error)
            }
        }
    }
    
    
    
    private func open (url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "NewsStoryTableViewCell",
                                                       for: indexPath) as? NewsStoryTableViewCell else { fatalError() }
        cell.configure(with: .init(model: stories[indexPath.row]))
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsStoryTableViewCell.prefHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView else { return nil }
        header.configure(with: .init(title: self.type.title,
                                     showAddButton: false))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.prefereHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let story = stories[indexPath.row]
        guard let url = URL(string: story.url) else {
            presentFailedTo()
            return
        }
        open(url: url)
    }
    private func presentFailedTo() {
        let alert = UIAlertController(title: "Unable to open",
                                      message: "We were Unable to open the Article",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil ))
        present(alert, animated: true)
        
    }
}
