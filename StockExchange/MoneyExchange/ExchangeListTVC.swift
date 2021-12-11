//
//  ExchangeListTVC.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import UIKit


class MovieTableViewCell: UITableViewCell {

    // MARK: - Properties
    let backGroundView = UIView()
    let topLineView = UIView()
    let bottomLineView = UIView()
    let splitLineView = UIView()

    let currencyLabel = UILabel()
    let bidLabel = UILabel()
    let askLabel = UILabel()
    
    let currencySymbolView = UIImageView()
    let screenWidth = UIScreen.main.bounds.width
    
    
    // MARK: - Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func prepareTableViewCell() {

        // prepare Background
        backgroundColor = .black
        selectionStyle = .none
        contentView.backgroundColor = .black
        contentView.superview?.backgroundColor = .black
        contentView.prepareHeight(constant: 72)
        contentView.addSubview(backGroundView)
        contentView.backgroundColor = .black

        backGroundView.prepareLayout(.leading)
        backGroundView.prepareLayout(.trailing)
        backGroundView.prepareLayout(.top)
        backGroundView.prepareLayout(.bottom)
        backGroundView.setBackgroundColor(.background)

        // prepare completedButton
        backGroundView.addSubview(currencySymbolView)
        currencySymbolView.prepareLayout(.leading,constant: 10)
        currencySymbolView.prepareLayout(.top,constant: 26)
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
        bidLabel.prepareTextField(size: .subtite,textcolor: .white)


        // prepare Title label
        backGroundView.addSubview(askLabel)
        askLabel.prepareLayout(.leading,constant: screenWidth * 0.7)
        askLabel.prepareLayout(.top)
        askLabel.prepareLayout(.bottom)
        askLabel.prepareLayout(.trailing,constant: -4)
        askLabel.textAlignment = .right
        askLabel.textColor = .white
        askLabel.prepareTextField(size: .subtite,textcolor: .white)

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
    
    func prepareCell(_ value: ExchangeData){
        
        guard value.isHeader else {

            currencySymbolView.setImage(value.currency.symbol().name())

            splitLineView.setBackgroundColor(.background)

            askLabel.prepareLabel(money: value.askValue)
            bidLabel.prepareLabel(money: value.bidValue)
            currencyLabel.text = value.currency.asText()
            bottomLineView.setBackgroundColor(.background)
            topLineView.setBackgroundColor(.headerBG)

            bidLabel.backgroundColor = value.bidValue.level.asColor().color()
            askLabel.backgroundColor = value.askValue.level.asColor().color()
            currencyLabel.backgroundColor = APPColor.background.color()
            backGroundView.backgroundColor = APPColor.background.color()
            
            topLineView.setBackgroundColor(.headerBG)
            bottomLineView.setBackgroundColor(.headerBG)
            return
        }

        
        askLabel.text = "Ask"
        bidLabel.text = "Bid"
        currencyLabel.text =  "Symbol"
        currencySymbolView.setImage(.symbol)
        backGroundView.setBackgroundColor(.headerBG)
        splitLineView.setBackgroundColor(.headerBG)
        askLabel.backgroundColor = APPColor.headerBG.color()
        bidLabel.backgroundColor = APPColor.headerBG.color()
        currencyLabel.backgroundColor = APPColor.headerBG.color()
        backGroundView.backgroundColor = APPColor.headerBG.color()
        
        
        topLineView.setBackgroundColor(.headerBorder)
        bottomLineView.setBackgroundColor(.headerBorder)
    }
}
