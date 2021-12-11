//
//  App.swift
//  StockExchange
//
//  Created by Godwin A on 10/12/21.
//

import UIKit


enum FontSize: CGFloat {
    
    case title = 20
    case subtite = 15
}


enum APPIMAGE: String {
    
    case symbol = "symbol"
    case currencyC = "currencyC"
    case currencyM = "currencyM"
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
        
        case .RED: return UIColor(red: 184/255, green: 32/255, blue: 32/255, alpha: 255)
        case .GREEN: return UIColor(red: 40/255, green: 160/255, blue: 40/255, alpha: 255)
            
        case .RedDull: return UIColor(red: 102/255, green: 33/255, blue: 33/255, alpha: 255)
        case .GreenDull: return UIColor(red: 34/255, green: 57/255, blue: 36/255, alpha: 255)

            
        case .headerBG: return UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 255)
        case .headerBorder: return .orange
        case .HeaderLabel: return .lightGray


        case .background: return UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 255)
        case .Label: return .white

        }
    }
}
