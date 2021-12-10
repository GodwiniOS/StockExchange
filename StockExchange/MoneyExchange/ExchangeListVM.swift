//
//  ExchangeListVM.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import Foundation
import UIKit


struct ExchangeData {
    
    var isHeader = false
    let currency: ExcahngeCurrency!
    let bidValue: MoneyData!
    let askValue: MoneyData!
}


enum APPIMAGE: String {
    
    case currencyC = "currencyC"
    case currencyM = "currencyM"
//    case symbol = "symbol"
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
    
    func color() -> UIColor{
        
        switch self {
        
        case .RED: return UIColor(red: 125/255, green: 32/255, blue: 32/255, alpha: 255)
        case .GREEN: return UIColor(red: 31/255, green: 71/255, blue: 34/255, alpha: 255)
        case .RedDull: return UIColor(red: 102/255, green: 33/255, blue: 33/255, alpha: 255)
        case .GreenDull: return UIColor(red: 34/255, green: 57/255, blue: 36/255, alpha: 255)

            
        case .headerBG: return .black
        case .headerBorder: return .orange
        case .HeaderLabel: return .lightGray


        case .background: return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 255)
        case .Label: return .white

        }
    }
}


enum ExcahngeSymbol {
    case C
    case M
    case symbol

    func name() -> APPIMAGE{
        switch self {
        case .C: return .currencyC
        case .M: return .currencyM
        case .symbol: return .currencyM

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
    var exchangeValues: [ExchangeData] = [ExchangeData(isHeader: true,
                                                       currency: nil, bidValue: nil, askValue: nil)]
    
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
                                      MoneyData(first: "0.90", second: 89, third: 7, level: .High),
                                      MoneyData(first: "122.", second: 54, third: 1, level: .High),
                                      MoneyData(first: " 1.81", second: 51, third: 9)]

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
