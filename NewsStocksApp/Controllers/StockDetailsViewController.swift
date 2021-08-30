//
//  StockDetailsViewController.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 27.08.2021.
//

import UIKit
import SafariServices



class StockDetailsViewController: UIViewController {

    
    //   MARK: Properties
    
    
    private let symbol:String
    private let companyName:String
    private var candleStickData: [CandleStick]
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        table.register(NewsStoryTableViewCell.self,
                       forCellReuseIdentifier: NewsStoryTableViewCell.identifier)
        return table
    }()
    
    
    
    private var stories: [NewsStory] = []
    
//
//    private var metrics: Metrics
    private var metrics: Metrics?
    
    
    
    //   MARK: Init
    
    init(symbol: String,
         companyName: String,
         candleStickData: [CandleStick] = []) {
        self.symbol = symbol
        self.companyName = companyName
        self.candleStickData = candleStickData
        super.init(nibName: nil, bundle: nil)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//   MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = companyName
        setUpCloseButton()
        setUpTable()
//        fetchFanData()
        fetchNews()
        
      
    }
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        
    }
    
    @objc private func didTapClose (){
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    private func  setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.tableHeaderView = UIView(frame: CGRect(
//                                            x: 0, y: 0, width: view.width,
//                                            height: (view.width * 0.7) + 100))
//
        
    }
  
    

    private func  fetchFanData() {
        let group = DispatchGroup()


        if candleStickData.isEmpty {
            group.enter()

        }


        group.enter()
        APIBase.shared.financMetrics(for: symbol) { result in
            defer {
                group.leave()

            }

            switch result {
            case.success(let response):
                let metrics = response.metric
                self.metrics = metrics
            case .failure(let error):
                print(error)


            }
        }



        group.notify(queue: .main) { [weak self] in
            self?.renderChart()
        }

    }

    
    
    
    private func fetchNews() {
        APIBase.shared.news(for: .compan(symbol: symbol)) { [weak self] result in
            switch result {
            case .success(let stories):
                DispatchQueue.main.sync {
                    self?.stories = stories
                    self?.tableView.reloadData()
                }
            case .failure(let error):
               print(error)
            
            
            }
        }
        
        
    }
    

   private func renderChart() {
    let headerView = StockDHeaderView(frame: CGRect(x: 0, y: 0,
                                                        width: view.width, height: (view.width * 0.7) + 100))


//        headerView.backgroundColor = .link

    var viewModels = [MetricCollectionViewCell.ViewModel]()
    if let metrics = metrics {
        viewModels.append(.init(name: "52W high", value: "\(String(describing: metrics.AnnualWeekHigh))"))
        viewModels.append(.init(name: "52L high", value: "\(String(describing: metrics.AnnualWeekLow))"))
        viewModels.append(.init(name: "52 Return", value: "\(String(describing: metrics.AnnualWeekPriceReturnDaily))"))
        viewModels.append(.init(name: "Beta", value: "\(String(describing: metrics.beta))"))
        viewModels.append(.init(name: "10D vol.", value: "\(String(describing: metrics.TenDayAverageTradingVolume))"))
    }




    headerView.configure(chartViewModel: .init(data: [], showLegend: false, showAxis: false),
                         metricViewModels: viewModels)




        tableView.tableHeaderView = headerView

    }
    
    

}


extension StockDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsStoryTableViewCell.identifier,
                                                       for: indexPath) as? NewsStoryTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: .init(model: stories[indexPath.row]))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsStoryTableViewCell.prefHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView else {
         return nil
            
        }
        header.delegate = self
//        header.configure(with: .init(title: symbol.uppercased(),
//                                     showAddButton: !PManager.shared.watchListContains(symbol: symbol)))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.prefereHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: stories[indexPath.row].url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    
    }
    
    
}


extension StockDetailsViewController: NewsHeaderViewDelegate {
    
    
    
    func NewsHeaderViewDidTapAddButton(_ headerView: NewsHeaderView) {
        headerView.button.isHidden = true
        PManager.shared.addToWatchList(symbol: symbol, companyName: companyName)
        
        
        let alert = UIAlertController(
            title: "add to watchlist",
            message: "we'ed added \(companyName) to your watchlist",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
        present(alert, animated: true)
        
    }
    
    
    
 //   fix bugs with StockDetailsViewController
    
}
