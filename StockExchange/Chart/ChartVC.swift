//
//  ChartVC.swift
//  StockExchange
//
//  Created by Godwin A on 10/12/21.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screeHeight = UIScreen.main.bounds.height


class StockChartView: UIView {
    

    

    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    //common func to init our view
    private func setupView() {
    }
    
//    override func draw(_ rect: CGRect) {
//        backgroundColor = .black
//    }
    
    func prepareCandles(candles: [CandleViewModel]) {
        
        for index in 1..<candles.count {

            let candle = candles[index]
            


            
            if candle.level == .Low {
                
                let redLayer: CALayer = {
                    let layer = CALayer()
                    layer.backgroundColor = UIColor.red.cgColor
                    return layer
                }()
                
                redLayer.frame = CGRect(x: Int(candle.position.x),
                                          y: Int(candle.position.y),
                                        width: Int(candle.width),
                                        height: Int(candle.height))
                
                layer.addSublayer(redLayer)

            } else {
                
                let greenLayer: CALayer = {
                    let layer = CALayer()
                    layer.backgroundColor = UIColor.green.cgColor
                    return layer
                }()
                greenLayer.frame = CGRect(x: Int(candle.position.x),
                                          y: Int(candle.position.y),
                                          width: Int(candle.width),
                                          height: Int(candle.height))

                layer.addSublayer(greenLayer)

            }
        }
    }
}




class ChartVC: UIViewController {

    var backGroundView = UIView()
    var chartView: StockChartView!

    var viewModel = ChartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        prepareView()

    }
    
    private func prepareView() {
        
        
        // prepare Background
        view.addSubview(backGroundView)

        backGroundView.prepareLayout(.leading)
        backGroundView.prepareLayout(.trailing)
        backGroundView.prepareLayout(.top)
        backGroundView.prepareLayout(.bottom)
        backGroundView.backgroundColor = .black


        chartView = StockChartView(frame: .init(x: 0, y: 0, width: 360, height: 240))
        // prepare Background
        backGroundView.addSubview(chartView)

        chartView.prepareLayout(.leading)
        chartView.prepareLayout(.top,constant: 100)
        
        chartView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        chartView.prepareCandles(candles: viewModel.candles)
        chartView.backgroundColor = .black
        
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self,
                                         selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func fireTimer() {
        chartView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        viewModel.generateNew()
        chartView.prepareCandles(candles: viewModel.candles)

    }
}

// VM

class ChartViewModel {
    
    var candles: [CandleViewModel] = []

    init(){
        initialValuesGenerator()
    }
    
    func initialValuesGenerator() {
        
        
        let randomValue = Float(Int.random(in: 50...100))
        let candlePosition = CandlePosition(x: 10, y: 1)
        let previousCandle = CandleViewModel(height: randomValue,
                                             position: candlePosition, level: .Low)

        for index in 0...200 {

            let newCandle = previousCandle.nextPosition(index)
            candles.append(CandleViewModel(height: newCandle.height,
                                           position: newCandle.position,
                                           level: newCandle.stock))
        }
        
    }
    
    
    func generateNew() {
        
        
        for index in 0..<200 {
            candles[index].changePosition(candles[index+1].position)
        }
        
        let newCandle = candles[200].nextPosition(200)

        let randomValue = Float(Int.random(in: 10...200))

        let x = Float(index) * space
        let y = Bool.random() ? position.x + randomValue/4 : position.x - randomValue/4

        
        candles.append(CandleViewModel(height: newCandle.height,
                                       position: newCandle.position,
                                       level: newCandle.stock))
    }
}




struct CandleViewModel {
    
    
    var height: Float
    let width: Float = 1
    let space: Float = 2
    var position: CandlePosition
    var level: StockLevel = .Low
    
    
    
    func nextPosition(_ index: Int) -> (position: CandlePosition,stock: StockLevel,height: Float) {

        var newPosition:CandlePosition?
        var stock:StockLevel?

        var validation = false
        var stockValue: Float?

        while !validation  {

            let randomValue = Float(Int.random(in: 10...200))

            let x = Float(index) * space
            let y = Bool.random() ? position.x + randomValue/4 : position.x - randomValue/4

            stockValue = randomValue
            newPosition = CandlePosition(x: x, y: y)
//            stock = height < randomValue ? .Low : .High
            stock = randomValue > 80 ? .High : .Low
            validation = y > 10 && (newPosition!.y + randomValue) < 600
        }
        
        return (newPosition!,stock!,stockValue!)
    }
    
    
    mutating func changePosition(_ newPosition: CandlePosition){
        position.y = newPosition.y
    }
    
    func newValueGenerate(){
        
    }
}

struct CandlePosition{
    let x: Float
    var y: Float
}
