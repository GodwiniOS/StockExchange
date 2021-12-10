//
//  ExchangeListVM.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import Foundation


struct ExchangeData {
    
    var isHeader = false
    let currency: ExcahngeCurrency!
    var bidValue: MoneyData!
    var askValue: MoneyData!
}


enum APPIMAGE: String {
    
    case currencyC = "currencyC"
    case currencyM = "currencyM"
    case symbol = "symbol"
}

enum StockLevel {
    
    case High
    case Low
    case normal

    func asColor() -> APPColor {
        switch self {
        case .High: return .GreenDull
        case .Low: return .RedDull
        case .normal: return .background
        }
    }
}


struct MoneyData {
    let first: Float
    let second: Int
    var third: Int?
    var level: StockLevel = .normal
    
    func labelAttributes() -> (asText: String,ranges: [NSRange],isLast: Bool) {
        
        let firstRange = NSMakeRange(0,first.text.count)
        let secondRange = NSMakeRange(first.text.count,second.text.count)
        let amount = first.text + second.text
        
        guard let last = third else { return (amount,[firstRange,secondRange],false) }
        let thirdrange = NSMakeRange(first.text.count+second.text.count, last.text.count)
        return (amount + last.text,[firstRange,secondRange,thirdrange],true)
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
        case .symbol: return .symbol

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


protocol ExchangeListViewModeldelegate: AnyObject {
    func reloadView()
}

class ExchangeListViewModel {
    
    // MARK: - Properties
    weak var delegate: ExchangeListViewModeldelegate?
    var exchangeValuesPrevious: [ExchangeData] = []
    var exchangeValues: [ExchangeData] = []
    let currencies: [ExcahngeCurrency] = [.EURUSD,.XAGUSD,.GBPUSD,.USDJPY,
                                            .LTCUSD,.ETHUSD,.EURAUD,.EURCHF,
                                          .EURGBP,.EURJPY,.GBPAUD]
    
    init() {
        addInitialVAlues()
    }
    
    private func addInitialVAlues(){
        
        

        
        let bidValues: [MoneyData] = [MoneyData(first: 1.16, second: 25, third: 8),
                                      MoneyData(first: 22, second: 75),
                                      MoneyData(first: 1.27, second: 90, third: 0, level: .Low),
                                      MoneyData(first: 105, second: 37, third: 6, level: .Low),
                                      MoneyData(first: 46, second: 32),
                                      MoneyData(first: 357, second: 54, level: .Low),
                                      MoneyData(first: 1.64, second: 99, third: 8),
                                      MoneyData(first: 1.07, second: 98, third: 6, level: .Low),
                                      MoneyData(first: 0.90, second: 89, third: 7, level: .High),
                                      MoneyData(first: 122, second: 54, third: 1, level: .High),
                                      MoneyData(first: 1.81, second: 51, third: 9)]

        let askValues: [MoneyData] = [MoneyData(first: 1.16, second: 29, third: 8),
                                      MoneyData(first: 22, second: 77),
                                      MoneyData(first: 1.27, second: 93, third: 0, level: .High),
                                      MoneyData(first: 105, second: 40, third: 0, level: .High),
                                      MoneyData(first: 46, second: 33),
                                      MoneyData(first: 357, second: 59, level: .Low),
                                      MoneyData(first: 1.65, second: 02, third: 6),
                                      MoneyData(first: 1.08, second: 02, third: 0, level: .High),
                                      MoneyData(first: 0.90, second: 91, third: 0, level: .Low),
                                      MoneyData(first: 122, second: 54, third: 5, level: .Low),
                                      MoneyData(first: 1.81, second: 53, third: 3)]
        
        
        exchangeValues.append(ExchangeData(isHeader: true,currency: nil, bidValue: nil, askValue: nil))
        
        for index in 1...10 {
            exchangeValues.append(ExchangeData(currency: currencies[index-1],
                                               bidValue: bidValues[index],
                                               askValue: askValues[index]))
            
        }
        exchangeValuesPrevious = exchangeValues
        
    }
    
    func generateSecondValues(){

        exchangeValues.removeAll()
        var newValues:[ExchangeData] = []
        newValues.append(ExchangeData(isHeader: true,currency: nil, bidValue: nil, askValue: nil))

        for index in 1...10 {
            
            if Bool.random() {
                
                var same = exchangeValuesPrevious[index]
                same.bidValue.level = .normal
                same.askValue.level = .normal
                newValues.append(same)
                continue
            }
            
            let randomBidIntSecond = Int.random(in: 0...99)
            let randomBidFloatFirst = round(Float.random(in: 1.01...99.99 * 100) / 100.0)
            let randomBidIntThird = Int.random(in: 0...9)

            
            let randomAskIntSecond = Int.random(in: 0...99)
            let randomAskFloafFirst = round(Float.random(in: 1.01...99.99 * 100) / 100.0)
            let randomAskIntThird = Int.random(in: 0...9)
            
            
            var newBid = MoneyData(first: randomBidFloatFirst, second: randomBidIntSecond, third: Bool.random() ? randomBidIntThird : nil)

            var newAsk = MoneyData(first: randomAskFloafFirst, second: randomAskIntSecond, third: Bool.random() ? randomAskIntThird : nil)


            newBid.level = newBid.first > exchangeValuesPrevious[index].bidValue.first ? .High : .Low
            newAsk.level = newAsk.first > exchangeValuesPrevious[index].askValue.first ? .High : .Low

            let newexchangeData = ExchangeData(currency: currencies[index-1],
                                               bidValue: newBid,
                                               askValue: newAsk)
            
            newValues.append(newexchangeData)
            
        }
        
        
        exchangeValues = newValues
        exchangeValuesPrevious = exchangeValues
        delegate?.reloadView()
    }
}
