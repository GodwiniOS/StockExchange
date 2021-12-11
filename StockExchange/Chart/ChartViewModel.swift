//
//  ChartViewModel.swift
//  StockExchange
//
//  Created by Godwin A on 10/12/21.
//

import Foundation

class ChartViewModel {
    
    var candles: [CandleViewModel] = []
    var timeLines: [TimeLineViewModel] = []

    init(){ initialValuesGenerator() }
    
    // MARK: - Methods
    func initialValuesGenerator() {
        
        
        candles.append(CandleViewModel(high: 180, low: 150, open: 175, close: 155))

        
        for index in 1..<200 {

            let candlevm = candles[index-1]
            let newCandle = candlevm.nextCandle(index)
            candles.append(newCandle)
        }
        
        
        
        for i in 1..<5 {
            
            let timeLine = TimeLineViewModel(startPosition: Position(x: Float(i * 75), y: 0),
                                             endPosition: Position(x: Float(i * 75), y: 210),
                                             textPosition: Position(x: Float((i * 75) - 18), y: 220))
            timeLines.append(timeLine)

        }
    
        
        
    }
    
    
    func generateNew() {


        candles.removeFirst()
        let newCandle = candles[198].nextCandle(199)
        candles.append(newCandle)
        
        for index in 0..<200 {
            candles[index].position.x = Float(index) * 1.5
        }
        

        var addNew = false
        for index in 0..<timeLines.count {
            
            let newX = timeLines[index].endPosition.x - 1.5

            if newX < 0 {
                addNew = true
            }
            
            timeLines[index].startPosition.x = newX
            timeLines[index].endPosition.x = newX
            timeLines[index].textPosition.x = newX - 18
        }
        
        if addNew {
            
            timeLines.removeFirst()
            timeLines.append(TimeLineViewModel(startPosition: Position(x: 300, y: 0),
                                               endPosition: Position(x: 300, y: 210),
                                               textPosition: Position(x: 300-18, y: 220)))
        }

        
        

        
        
        
        
        
    }
}


struct Position {
    var x: Float
    var y: Float
}

struct TimeLineViewModel {
    var startPosition: Position
    var endPosition: Position
    var textPosition: Position
}


class CandleViewModel {
    
    let high: Int
    let low: Int
    let open: Int
    let close: Int
    
    
    var height: Int
    let width: Int = 1
    let space: Float = 0.5
    var position: Position
    var level: StockLevel = .Low
    
    
    init(high: Int, low: Int, open: Int, close: Int){
        self.high = high
        self.low = low
        self.open = open
        self.close = close
        height = high - low
        position = Position(x: 0, y: 30)
        }
    
    
    init(high: Int, low: Int, open: Int, close: Int,height: Int,position: Position,level: StockLevel){
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
            
            let newClose = newLevel == .High ? newOpen + Int(random/5) : newOpen - Int(random/5)

            let newHigh = newLevel == .High ? newClose + 5 : newOpen + 5
            let newLow = newLevel == .High ? newClose - 5 : newOpen - 5
            let newHeight = high - low
            let newPosition = Position(x: Float(index) * 1.5, y: Float(210 - newHigh))
            
            validation = newPosition.y > 15 && newPosition.y < 190
            newCandleViewModel = CandleViewModel(high: newHigh, low: newLow, open: newOpen, close: newClose, height: newHeight, position: newPosition, level: newLevel)
        }
        
        return newCandleViewModel!
    }
    
}

