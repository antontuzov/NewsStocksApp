//
//  WatchllistTableViewCell.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit

protocol WatchllistTableViewCellDelegate: AnyObject {
    func didUpDateWidth()
}

class WatchllistTableViewCell: UITableViewCell {
//    static let identifier = "WatchllistTableViewCell"
    
    weak var delegate: WatchllistTableViewCellDelegate?
    
    
    static let prffHight: CGFloat = 60
    
    
    struct PriceViewModel {
        let symbol: String
        let companyName: String
        let price: String
        let changeColor: UIColor
        let changePre: String
        let chardViewModel: StockChartView.StockviewModel
    }
    
    
    
    
    private lazy var symbolLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private lazy var nameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    
    private lazy var priceLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        lable.textAlignment = .right
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private lazy var changeLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        lable.textColor = .white
        lable.textAlignment = .right
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 5
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let miniChartView: StockChartView = {
        let chart = StockChartView()
//        chart.backgroundColor = .link
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        return chart
    }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews(  symbolLable,
                      nameLable,
                      priceLable,
                      changeLable,
                      miniChartView
      
        )
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        symbolLable.sizeToFit()
        nameLable.sizeToFit()
        priceLable.sizeToFit()
        changeLable.sizeToFit()
        
        
        
//        let yStart: CGFloat = (contentView.height - symbolLable.height - nameLable.height)/2
//        symbolLable.frame = CGRect(x: separatorInset.left,
//                                   y: yStart,
//                                   width: symbolLable.width,
//                                   height: symbolLable.height)
//
//
//
//        nameLable.frame = CGRect(x: separatorInset.left,
//                                 y: symbolLable.bottom,
//                                   width: nameLable.width,
//                                   height: nameLable.height)
        
        
//       let currentWidth = max(max(priceLable.width, changeLable.width),WatchListViewController.maxWidth)
//
//
//        if currentWidth > WatchListViewController.maxWidth {
//            WatchListViewController.maxWidth = currentWidth
//            delegate?.didUpDateWidth()
//        }
//
//        priceLable.frame = CGRect(
//            x: contentView.width - 10 - currentWidth,
//            y: 3,
//            width: currentWidth ,
//            height: priceLable.height)
//
//
//
//        changeLable.frame = CGRect(
//            x: contentView.width - 10 - currentWidth,
//            y: priceLable.bottom + 5,
//            width:  currentWidth,
//            height:  changeLable.height)
//
        
        
//
//        miniChartView.frame = CGRect(x: priceLable.left - (contentView.width/3) - 5,
//                                     y: 6,
//                                     width: contentView.width/3,
//                                     height: contentView.height - 12)
//
//
//
//


        
        
        
        setUpCons()
        
        
    }
    
    
    private func  setUpCons() {
        
        
        NSLayoutConstraint.activate([
        
            symbolLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            symbolLable.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        
        ])
        
        NSLayoutConstraint.activate([
        
            nameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLable.topAnchor.constraint(equalTo: symbolLable.bottomAnchor, constant: 5)
        
        ])
        
        
        
        NSLayoutConstraint.activate([
        
            priceLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            priceLable.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        
        ])
        
        NSLayoutConstraint.activate([
        
            changeLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            changeLable.topAnchor.constraint(equalTo: priceLable.bottomAnchor, constant: 5)
        
        ])
        
        NSLayoutConstraint.activate([

//            miniChartView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            miniChartView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)

            miniChartView.trailingAnchor.constraint(equalTo:  priceLable.leadingAnchor, constant: 0),
            miniChartView.trailingAnchor.constraint(equalTo:  changeLable.leadingAnchor, constant: 0),
            
            miniChartView.heightAnchor.constraint(equalToConstant: 60),
            miniChartView.widthAnchor.constraint(equalToConstant: 200)
            
        ])

        
    }
    
    
 
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        symbolLable.text = nil
        nameLable.text = nil
        priceLable.text = nil
        changeLable.text = nil
        miniChartView.reset()
    }
    
    
    public func configure(with viewModel:  PriceViewModel) {
        symbolLable.text = viewModel.symbol
        nameLable.text = viewModel.companyName
        priceLable.text = viewModel.price
        changeLable.text = viewModel.changePre
        changeLable.backgroundColor = viewModel.changeColor
    
        miniChartView.configure(with: viewModel.chardViewModel)
        
        
        
        
    }
    
    
    
}
