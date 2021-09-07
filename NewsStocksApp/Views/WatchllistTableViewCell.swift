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
    static let identifier = "WatchllistTableViewCell"
    
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
        return lable
    }()
    
    
    private lazy var nameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        return lable
    }()
    
    
    
    private lazy var priceLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        lable.textAlignment = .right
        return lable
    }()
    
    
    private lazy var changeLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        lable.textColor = .white
        lable.textAlignment = .right
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 5
        return lable
    }()
    
    private let miniChartView: StockChartView = {
        let chart = StockChartView()
//        chart.backgroundColor = .link
        chart.clipsToBounds = true
        
        
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
        
        
        
        let yStart: CGFloat = (contentView.height - symbolLable.height - nameLable.height)/2
        symbolLable.frame = CGRect(x: separatorInset.left,
                                   y: yStart,
                                   width: symbolLable.width,
                                   height: symbolLable.height)
        
        
        
        nameLable.frame = CGRect(x: separatorInset.left,
                                 y: symbolLable.bottom,
                                   width: nameLable.width,
                                   height: nameLable.height)
        
        
       let currentWidth = max(max(priceLable.width, changeLable.width),WatchListViewController.maxWidth)
        
        
        if currentWidth > WatchListViewController.maxWidth {
            WatchListViewController.maxWidth = currentWidth
            delegate?.didUpDateWidth()
        }
        
        priceLable.frame = CGRect(
            x: contentView.width - 10 - currentWidth,
            y: 3,
            width: currentWidth ,
            height: priceLable.height)
        
        
        
        changeLable.frame = CGRect(
            x: contentView.width - 10 - currentWidth,
            y: priceLable.bottom + 5,
            width:  currentWidth,
            height:  changeLable.height)
        
        
        
        
        miniChartView.frame = CGRect(x: priceLable.left - (contentView.width/3) - 5,
                                     y: 6,
                                     width: contentView.width/3,
                                     height: contentView.height - 12)
        
        
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
        
    }
    
    
    
}
