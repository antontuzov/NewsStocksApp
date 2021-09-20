//
//  StockDHeaderView.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 30.08.2021.
//

import UIKit


class StockDHeaderView: UIView,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    
    
    private var metricViewModels:[MetricCollectionViewCell.MetricViewModel] = []

//     Subviews
    private let chartView = StockChartView()
    
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MetricCollectionViewCell.self,
                                forCellWithReuseIdentifier: "MetricCollectionViewCell")
        
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubviews(chartView, collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = CGRect(x: 0, y: 0, width: width, height: height-100)
        collectionView.frame = CGRect(x: 0, y: height-50, width: width, height: 50)
    }

    
    
    
    func configure(
        chartViewModel: StockChartView.StockviewModel,
        metricViewModels: [MetricCollectionViewCell.MetricViewModel]) {

        
        
        chartView.configure(with: chartViewModel)
        
        self.metricViewModels = metricViewModels
        collectionView.reloadData()


    }
  
    
//     MARK: - CollectionView
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return metricViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = metricViewModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "MetricCollectionViewCell", for: indexPath) as? MetricCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModel)
//        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width/2, height: 100/3)
    }
    
}
