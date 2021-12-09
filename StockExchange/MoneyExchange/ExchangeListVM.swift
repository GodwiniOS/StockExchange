//
//  ExchangeListVM.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import Foundation
import UIKit


struct ExchangeData {
    
    let currency: ExcahngeCurrency
    let bidValue: MoneyData
    let askValue: MoneyData
}

enum StockLevel {
    
    case High
    case Low
    case veryHigh
    case veryLow
    case normal

    func asColor() -> APPColor {
        switch self {
        case .High: return .GREEN
        case .Low: return .RED
        case .veryHigh: return .GREEN
        case .veryLow: return .RED
        case .normal: return .background
        }
    }
}


struct MoneyData {
    let first: String
    let second: Int
    var third: Int?
    var level: StockLevel = .normal
    
    func labelAttributes() -> (asText: String,ranges: [NSRange],isLast: Bool) {
        
        let firstRange = NSMakeRange(0,first.count)
        let secondRange = NSMakeRange(first.count,second.text.count)
        let amount = first + second.text
        
        guard let last = third else { return (amount,[firstRange,secondRange],false) }
        let thirdrange = NSMakeRange(first.count+second.text.count, last.text.count)
        return (amount + last.text,[firstRange,secondRange,thirdrange],true)
    }
}

enum APPColor {
    
    case RED
    case GREEN
    case RedDull
    case GreenDull
    
    case headerBG
    case headerBorder
    case HeaderLabel

    case background
    case Label
    
    func asColor() -> UIColor{
        
        switch self {
        
        case .RED: return .red
        case .GREEN: return .green
        case .RedDull: return .red
        case .GreenDull: return .green

            
        case .headerBG: return .black
        case .headerBorder: return .orange
        case .HeaderLabel: return .lightGray


        case .background: return .darkGray
        case .Label: return .white

        }
    }
}


enum ExcahngeSymbol {
    case C
    case M
    
    func asText() -> String{
        switch self {
        case .C: return "logoC"
        case .M: return "logoM"
            
        }
    }
}


enum ExcahngeCurrency: String {
    
    case EURUSD
    case XAGUSD
    case GBPUSD
    case USDJPY
    case LTCUSD
    case ETHUSD
    case EURAUD
    case EURCHF
    case EURGBP
    case EURJPY
    case GBPAUD
    
    func symbol() -> ExcahngeSymbol{
        return self == ExcahngeCurrency.XAGUSD ? .C : .M
    }
    
    func asText() -> String{
        return self.rawValue
    }
}

class ExchangeListViewModel {
    
    // MARK: - Properties
    var exchangeValues: [ExchangeData] = []
    
    init() {
        addInitialVAlues()
    }
    
    private func addInitialVAlues(){
        
        
        let currencies: [ExcahngeCurrency] = [.EURUSD,.XAGUSD,.GBPUSD,.USDJPY,
                                                .LTCUSD,.ETHUSD,.EURAUD,.EURCHF,
                                              .EURGBP,.EURJPY,.GBPAUD]
        
        let bidValues: [MoneyData] = [MoneyData(first: "1.16", second: 25, third: 8),
                                      MoneyData(first: "22.", second: 75),
                                      MoneyData(first: "1.27", second: 90, third: 0, level: .Low),
                                      MoneyData(first: "105.", second: 37, third: 6, level: .Low),
                                      MoneyData(first: "46.", second: 32),
                                      MoneyData(first: "357.", second: 54, level: .veryLow),
                                      MoneyData(first: "1.64", second: 99, third: 8),
                                      MoneyData(first: "1.07", second: 98, third: 6, level: .Low),
                                      MoneyData(first: "0.90", second: 89, third: 7),
                                      MoneyData(first: "122.", second: 54, third: 1, level: .High),
                                      MoneyData(first: " 1.81", second: 51, third: 9, level: .High)]

        let askValues: [MoneyData] = [MoneyData(first: "1.16", second: 29, third: 8),
                                      MoneyData(first: "22.", second: 77),
                                      MoneyData(first: "1.27", second: 93, third: 0, level: .High),
                                      MoneyData(first: "105.", second: 40, third: 0, level: .High),
                                      MoneyData(first: "46.", second: 33),
                                      MoneyData(first: "357.", second: 59, level: .veryLow),
                                      MoneyData(first: "1.65", second: 02, third: 6),
                                      MoneyData(first: "1.08", second: 02, third: 0, level: .High),
                                      MoneyData(first: "0.90", second: 91, third: 0, level: .Low),
                                      MoneyData(first: "122.", second: 54, third: 5, level: .Low),
                                      MoneyData(first: "1.81", second: 53, third: 3)]
        
        
        for index in 0...10 {
            exchangeValues.append(ExchangeData(currency: currencies[index],
                                               bidValue: bidValues[index],
                                               askValue: askValues[index]))
            
        }
    }
}
