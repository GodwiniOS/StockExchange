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
        
        

    }
    
    func prepredashVer(timelines: [TimeLineViewModel]){
        
        var i = 0
        for timline in timelines {
            
            let dashLayer = CAShapeLayer()
            dashLayer.strokeColor = UIColor.gray.cgColor
            dashLayer.lineWidth = 1
            dashLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
            
            
            path.addLines(between: [
                CGPoint(x: CGFloat(timline.startPosition.x),y:  CGFloat(timline.startPosition.y)),
                CGPoint(x: CGFloat(timline.endPosition.x), y: CGFloat(timline.endPosition.y))
            ])
            
                          
                          
                          
                          
        dashLayer.path = path
        layer.addSublayer(dashLayer)
            
            let textlayer = CATextLayer()

            textlayer.frame = CGRect(x: (i * 75) - 18 , y: 220, width: 100, height: 40)
            
            textlayer.frame = CGRect(x: CGFloat(timline.textPosition.x), y: CGFloat(timline.textPosition.y),
                                     width: 100, height: 40)
            
            textlayer.fontSize = 12
            textlayer.alignmentMode = .left
            
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date).text
            let minutes = Int(calendar.component(.minute, from: date)) - (4-i)
            i = i + 1
            let sec = calendar.component(.minute, from: date).text

            textlayer.string =  hour + ":" +  minutes.text  + ":" + sec
            
            textlayer.isWrapped = true
            textlayer.truncationMode = .end
            textlayer.foregroundColor = UIColor.white.cgColor

            layer.addSublayer(textlayer)
        }
    }
    
    
    func prepreTextLayer(initialValue: Int,decimal: Int){
        

        for i in 0..<6 {
            
            let textlayer = CATextLayer()

            textlayer.frame = CGRect(x: 305 , y: 22 + (i * 30), width: 100, height: 40)
            textlayer.fontSize = 12
            textlayer.alignmentMode = .left
            textlayer.string = "\(initialValue).\(decimal)\(90 - (i * 15))"
            textlayer.isWrapped = true
            textlayer.truncationMode = .end
            textlayer.foregroundColor = UIColor.white.cgColor

            layer.addSublayer(textlayer)
        }
    }
    
    
    
    func prepareTimeline(timelines: [TimeLineViewModel],initialValue: Int,decimal: Int,value: Int?){
        prepare()
        prepreTextLayer(initialValue: initialValue, decimal: decimal)
        prepredashVer(timelines: timelines)
        if value != nil {
            prepareCurrentLine(value: value!,initialValue: initialValue, decimal: decimal)
        }
    }
    
    func prepareCurrentLine(value: Int,initialValue: Int, decimal: Int){
        
        
        let line: CALayer = {
            let layer = CALayer()
            layer.backgroundColor = UIColor.orange.cgColor
            return layer
        }()

        line.frame = CGRect(x: 0, y: 210 - value, width: 300,height: 1)
        layer.addSublayer(line)
        
        
        let textlayer = CATextLayer()

        textlayer.frame = CGRect(x: 310, y: 210 - value, width: 100, height: 40)
        textlayer.fontSize = 8
        textlayer.alignmentMode = .left
        textlayer.string = "\(initialValue).\(decimal)\(value)"
        textlayer.isWrapped = true
        textlayer.truncationMode = .end
        textlayer.foregroundColor = UIColor.orange.cgColor

        layer.addSublayer(textlayer)
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

