//
//  ChartView.swift
//  StockExchange
//
//  Created by Godwin A on 10/12/21.
//

import UIKit

class StockChartView: UIView {
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        
    }
    
    
    // MARK: - Methods
    func prepare() {
        let line1: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.gray.cgColor
            return layer
        }()

        line1.frame = CGRect(x: 0,y: 0,width: 300,height: 2)
        layer.addSublayer(line1)
        
        let line2: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.gray.cgColor
            return layer
        }()

        line2.frame = CGRect(x: 0, y: 0, width: 2,height: 210)
        layer.addSublayer(line2)
        
        let line3: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.gray.cgColor
            return layer
        }()

        line3.frame = CGRect(x: 0, y: 210, width: 300,height: 2)
        layer.addSublayer(line3)
        
        let line4: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.gray.cgColor
            return layer
        }()

        line4.frame = CGRect(x: 300, y: 0, width: 2,height: 210)
        layer.addSublayer(line4)
        
        
        for i in 1..<7 {
            
            let dashLayer = CAShapeLayer()
            dashLayer.strokeColor = UIColor.gray.cgColor
            dashLayer.lineWidth = 1
            dashLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: i * 30), CGPoint(x: 300, y: i * 30)])
        dashLayer.path = path
        layer.addSublayer(dashLayer)
            

            
        }
        
        
        prepreTextLayer()
        prepredashVer()
    }
    
    func prepredashVer(){
        
        for i in 1..<4 {
            
            let dashLayer = CAShapeLayer()
            dashLayer.strokeColor = UIColor.gray.cgColor
            dashLayer.lineWidth = 1
            dashLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: i * 75, y: 0), CGPoint(x: i * 75, y: 210)])
        dashLayer.path = path
        layer.addSublayer(dashLayer)
            
        }
    }
    
    
    func prepreTextLayer(){
        

        for i in 0..<6 {
            
            let textlayer = CATextLayer()

            textlayer.frame = CGRect(x: 305 , y: 22 + (i * 30), width: 100, height: 40)
            textlayer.fontSize = 12
            textlayer.alignmentMode = .left
            textlayer.string = "fjfifdkmfkdj"
            textlayer.isWrapped = true
            textlayer.truncationMode = .end
            textlayer.foregroundColor = UIColor.white.cgColor

            layer.addSublayer(textlayer)
        }
    }
    
    
    
    

    func prepareCandles(candles: [CandleViewModel]) {
        
        for candle in candles {
            let stick: CALayer = {
                let layer = CALayer()
                layer.backgroundColor = candle.level == .High ? UIColor.green.cgColor :  UIColor.red.cgColor
                return layer
            }()

            stick.frame = CGRect(x: Int(candle.position.x),y: Int(candle.position.y),width: candle.width,height: candle.height)
            layer.addSublayer(stick)
        }
    }
}

