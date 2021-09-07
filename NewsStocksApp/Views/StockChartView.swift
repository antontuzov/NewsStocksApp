//
//  StockChartView.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit

class StockChartView: UIView {

    //    MARK: Render

        struct StockviewModel {
            let data: [Double]
            let showLegend: Bool
            let showAxis: Bool
            
        }
        

        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        
        
        func reset() {
            
            
            
        }
        
        
        func configure(with viewModel: StockviewModel) {
            
            
            
            
        }
}
