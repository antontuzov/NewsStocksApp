//
//  StockChartView.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit
import Charts

class StockChartView: UIView {

    //    MARK: Render

        struct StockviewModel {
            let data: [Double]
            let showLegend: Bool
            let showAxis: Bool
            let fillColor: UIColor
            
        }
    
    
    lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false

        return chartView
    }()
    
    

    //    MARK: Init
    
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(chartView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            chartView.frame = bounds
        }
        
        
        func reset() {
            chartView.data = nil
            
            
        }
        
        
        func configure(with viewModel: StockviewModel) {
            var entries = [ChartDataEntry]()
            
            for (index, value) in viewModel.data.enumerated() {
                entries.append(.init(x: Double(index),
                                     y: value))
                
            }
            
            
            chartView.rightAxis.enabled = viewModel.showAxis
            chartView.legend.enabled = viewModel.showLegend
            
            
            let dataSet = LineChartDataSet(entries: entries, label: "7 days ")
            dataSet.fillColor = viewModel.fillColor
            dataSet.drawFilledEnabled = true
            dataSet.drawIconsEnabled = false
            dataSet.drawValuesEnabled = false
            dataSet.drawCirclesEnabled = false
        
            
            let data = LineChartData(dataSet: dataSet)
            chartView.data = data
            
            
        }
}
