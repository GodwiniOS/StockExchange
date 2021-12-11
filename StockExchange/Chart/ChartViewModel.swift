//
//  ChartViewModel.swift
//  StockExchange
//
//  Created by Godwin A on 10/12/21.
//

import Foundation

class ChartViewModel {
    
    var candles: [CandleViewModel] = []

    init(){ initialValuesGenerator() }
    
    // MARK: - Methods
    func initialValuesGenerator() {
        
        
        candles.append(CandleViewModel(high: 180, low: 150, open: 175, close: 155))

        
        for index in 1..<200 {

            let candlevm = candles[index-1]
            let newCandle = candlevm.nextCandle(index)
            candles.append(newCandle)
        }
        
    }
    
    
//    func generateNew() {
//
//
//        for index in 0..<200 {
//            candles[index].changePosition(candles[index+1].position)
//        }
//
//        let newCandle = candles.last!.nextPosition(200)
//        candles.removeLast()
//
//        candles.append(CandleViewModel(height: newCandle.height,
//                                       position: newCandle.position,
//                                       level: newCandle.stock))
//    }
}


struct CandlePosition{
    var x: Float
    var y: Float
}

//struct CandleViewModel {
//
//
//    var height: Float
//    let width: Float = 1
//    let space: Float = 2.5
//    var position: CandlePosition
//    var level: StockLevel = .Low
//
//
//
//    func nextPosition(_ index: Int) -> (position: CandlePosition,stock: StockLevel,height: Float) {
//
//        var newPosition:CandlePosition?
//        var stock:StockLevel?
//        var validation = false
//        var stockValue: Float?
//
//        while !validation  {
//
//            let randomValue = Float().chartRandom
//
//            let x = Float(index) * space
//            let y = Bool.random() ? position.y - randomValue : position.y + randomValue
//
//            stockValue = randomValue
//            newPosition = CandlePosition(x: x, y: y)
//            stock =  .Low //randomValue > 20 ? .High : .Low
//            validation = y > 10 && (newPosition!.y + randomValue) < 210
//        }
//
//        return (newPosition!,stock!,stockValue!)
//    }
//
//
//    mutating func changePosition(_ newPosition: CandlePosition){
//        position.x = newPosition.x
//    }
//
//    func newValueGenerate(){
//
//    }
//}



class CandleViewModel {
    
    let high: Int
    let low: Int
    let open: Int
    let close: Int
    
    
    var height: Int
    let width: Int = 1
    let space: Float = 0.5
    var position: CandlePosition
    var level: StockLevel = .Low
    
    
    init(high: Int, low: Int, open: Int, close: Int){
        self.high = high
        self.low = low
        self.open = open
        self.close = close
        height = high - low
        position = CandlePosition(x: 0, y: 30)
        }
    
    
    init(high: Int, low: Int, open: Int, close: Int,height: Int,position: CandlePosition,level: StockLevel){
        self.high = high
        self.low = low
        self.open = open
        self.close = close
        
        
        self.height = height
        self.position = position
        self.level = level
        }
    
    
    func nextCandle(_ index: Int) -> CandleViewModel {

        var validation = false
        var newCandleViewModel: CandleViewModel?
        while !validation {
            let random = Float().chartRandom
            let newOpen = close
            let newLevel: StockLevel = Bool.random() ? .Low : .High
//            let newClose = newLevel == .High ? newOpen + Int(random) : newOpen - Int(random)
            
            let newClose = newLevel == .High ? newOpen + Int(random/3.8) : newOpen - Int(random/3.8)

            let newHigh = newLevel == .High ? newClose + 5 : newOpen + 5
            let newLow = newLevel == .High ? newClose - 5 : newOpen - 5
            let newHeight = high - low
            let newPosition = CandlePosition(x: Float(index) * 1.5, y: Float(210 - newHigh))
            
            validation = newPosition.y > 15 && newPosition.y < 190
            newCandleViewModel = CandleViewModel(high: newHigh, low: newLow, open: newOpen, close: newClose, height: newHeight, position: newPosition, level: newLevel)
        }
        
        return newCandleViewModel!
    }
    
}

