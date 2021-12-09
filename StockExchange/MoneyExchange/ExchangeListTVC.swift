//
//  ExchangeListTVC.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    let topLineView = UIView()
    let bottomLineView = UIView()
    let splitLineView = UIView()

    let currencyLabel = UILabel()
    let bidLabel = UILabel()
    let askLabel = UILabel()
    
    let currencySymbolView = UIImageView()
    
    
    let screenWidth = UIScreen.main.bounds.width
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareTableViewCell() {
        

        // prepare Background
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.superview?.backgroundColor = .clear
        contentView.prepareHeight(constant: 80)
        contentView.addSubview(backGroundView)

        backGroundView.prepareLayout(.leading)
        backGroundView.prepareLayout(.trailing)
        backGroundView.prepareLayout(.top)
        backGroundView.prepareLayout(.bottom)
        backGroundView.setBackgroundColor(.background)
        




        // prepare completedButton
        backGroundView.addSubview(currencySymbolView)
        currencySymbolView.prepareLayout(.leading,constant: 10)
        currencySymbolView.prepareLayout(.top,constant: 30)
        currencySymbolView.prepareHeight(constant: 20)
        currencySymbolView.prepareWidth(constant: 20)
        currencySymbolView.setBackgroundColor(.HeaderLabel)
        currencySymbolView.contentMode = .scaleAspectFill

        

        // prepare Title label
        backGroundView.addSubview(currencyLabel)
        currencyLabel.prepareLayout(.leading,constant: screenWidth * 0.1)
        currencyLabel.prepareWidth(constant: screenWidth * 0.3)
        currencyLabel.prepareLayout(.top)
        currencyLabel.prepareLayout(.bottom)
        currencyLabel.prepareTextField(size: .title,textcolor: .white)
        currencyLabel.textAlignment = .left
        currencyLabel.numberOfLines = 0

        // prepare Title label
        backGroundView.addSubview(bidLabel)
        bidLabel.prepareLayout(.leading,constant: screenWidth * 0.4)
        bidLabel.prepareLayout(.top)
        bidLabel.prepareLayout(.bottom)
        bidLabel.prepareWidth(constant: screenWidth * 0.3)
        bidLabel.numberOfLines = 0
        bidLabel.textAlignment = .right
        bidLabel.textColor = .white


        // prepare Title label
        backGroundView.addSubview(askLabel)
        askLabel.prepareLayout(.leading,constant: screenWidth * 0.7)
        askLabel.prepareLayout(.top)
        askLabel.prepareLayout(.bottom)
        askLabel.prepareLayout(.trailing,constant: -10)
        askLabel.textAlignment = .right
        askLabel.textColor = .white

//        askLabel.prepareTextField(size: .subtite)
        // prepare completedButton

        
        backGroundView.addSubview(splitLineView)
        splitLineView.prepareLayout(.top)
        splitLineView.prepareLayout(.bottom)
        splitLineView.prepareLayout(.leading,constant: screenWidth * 0.7)
        splitLineView.prepareWidth(constant: 2)
        splitLineView.setBackgroundColor(.headerBorder)
        
        backGroundView.addSubview(topLineView)
        topLineView.prepareLayout(.leading)
        topLineView.prepareLayout(.trailing)
        topLineView.prepareLayout(.top)
        topLineView.prepareHeight(constant: 2)
        topLineView.setBackgroundColor(.headerBorder)
        
        backGroundView.addSubview(bottomLineView)
        bottomLineView.prepareLayout(.leading)
        bottomLineView.prepareLayout(.trailing)
        bottomLineView.prepareLayout(.bottom)
        bottomLineView.prepareHeight(constant: 1)
        bottomLineView.setBackgroundColor(.headerBorder)
        
    }
    
    func prepareCell(_ data: ExchangeData? = nil){
        


        guard let value = data else {

            askLabel.text = "Ask"
            bidLabel.text = "Bid"
            currencyLabel.text =  "Symbol"
            backGroundView.setBackgroundColor(.headerBG)
            splitLineView.setBackgroundColor(.headerBG)

            return
        }

        splitLineView.setBackgroundColor(.background)

        askLabel.prepareLabel(money: value.askValue)
        bidLabel.prepareLabel(money: value.bidValue)
        currencyLabel.text = value.currency.asText()
        bottomLineView.setBackgroundColor(.background)
        topLineView.setBackgroundColor(.headerBG)

        


    }
}
