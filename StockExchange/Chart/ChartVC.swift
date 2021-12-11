//
//  ChartVC.swift
//  StockExchange
//
//  Created by Godwin A on 10/12/21.
//

import UIKit


class ChartVC: UIViewController {

    // MARK: - UI PROPERTIES
    var backGroundView = UIView()
    var chartView: StockChartView!
    var viewModel = ChartViewModel()

    var currency:(first:Float,second:Int)?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        prepareView()
    }
    
    
    // MARK: - Methods
    private func prepareView() {
        
        
        // prepare Background
        view.addSubview(backGroundView)

        backGroundView.prepareLayout(.leading)
        backGroundView.prepareLayout(.trailing)
        backGroundView.prepareLayout(.top)
        backGroundView.prepareLayout(.bottom)
        backGroundView.backgroundColor = .black

        // prepare chartView
        chartView = StockChartView(frame: .init(x: 0, y: 30, width: 360, height: 240))
//        chartView.drawDottedLine(start: .zero, end: CGPoint(x: 210, y: 0))
        backGroundView.addSubview(chartView)

        chartView.prepareLayout(.leading)
        chartView.prepareLayout(.top,constant: 100)
        chartView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let first:Int = Int(currency?.first ?? 1)
        let second:Int = Int(currency?.second ?? 56)
        chartView.prepareTimeline(timelines: viewModel.timeLines, initialValue: first,
                                  decimal: second)
        chartView.prepareCandles(candles: viewModel.candles)

        chartView.backgroundColor = .black
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self,
                                         selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    @objc func fireTimer() {

        chartView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        

        viewModel.generateNew()
        let first:Int = Int(currency?.first ?? 1)
        let second:Int = Int(currency?.second ?? 56)
        chartView.prepareTimeline(timelines: viewModel.timeLines, initialValue: first,
                                  decimal: second)
        chartView.prepareCandles(candles: viewModel.candles)
    }
}
