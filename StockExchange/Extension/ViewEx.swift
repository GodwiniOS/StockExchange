//
//  ViewEx.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import UIKit

extension UIView {
    
    func prepareLayout(_ attribute: NSLayoutConstraint.Attribute,
                       toItem :UIView? = nil,
                       constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        let withItem: UIView! =  toItem != nil ? toItem! : superview
        let withAttribute: NSLayoutConstraint.Attribute! = toItem != nil ? .bottom : attribute

        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: withItem,
                                        attribute: withAttribute,
                                        multiplier: 1,
                                        constant: constant)
        
        NSLayoutConstraint.activate([layout])
    }
    
    
    func prepareHeight(constant: CGFloat) {
        
//        self.frame = CGRect(x: self.frame.minX, y: self.frame.minX, width: self.frame.width, height: constant)
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)

        NSLayoutConstraint.activate([constraint])
        
    }
    
    func prepareWidth(constant: CGFloat) {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)
        NSLayoutConstraint.activate([constraint])
    }
    
    
    func cornerRadius(constant: CGFloat = 10,color: UIColor,
                      width: CGFloat = 1){
        layer.cornerRadius = constant;
        layer.masksToBounds = true;
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func borderView(constant: CGFloat = 10,color: UIColor,
                      width: CGFloat = 1){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    
    func setBackgroundColor(_ color: APPColor) {
        backgroundColor = color.color()
    }
    

    
    func setBackgroundColorCurrency(_ level: StockLevel) {
        
        

        
    }
    
}


extension UIImageView {

    func setImage(_ name: APPIMAGE) {
        image = UIImage(named: name.rawValue)
    }
}




extension UITableView {

    func registerCell() {
        self.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }
}



extension UIViewController {
    // MARK: - To get the height of Navigation bar to assign title top spacing
    func topbarHeight() -> CGFloat {
        return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 + (navigationController?.navigationBar.frame.height ?? 0)
    }
}

extension UILabel{

    func prepareTextField(size: FontSize,textcolor: UIColor = .black) {
        font = font.withSize(size.rawValue)
        textColor = textcolor
    }
    
    
    func prepareLabel(money: MoneyData) {
        
        
        let labelAttributes =  money.labelAttributes()
        
        let amountText = NSMutableAttributedString.init(string: labelAttributes.asText)
        
        
        
        // set the custom font and color for the 0,1 range in string
        amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)],
                                 range: labelAttributes.ranges[0])
        
        amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)],
                                 range: labelAttributes.ranges[1])
        
        if labelAttributes.isLast {
            amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
                                     range: labelAttributes.ranges[2])
        }
        attributedText = amountText
    }
}


extension Int {
    var text : String {
        return "\(self)"
    }
}

extension Float {
    
    var text : String {
        
        
        var asText = "\(self)"
        
        
        while asText.contains("."),let last = asText.last,last == "0" {
            asText = String(asText.dropLast())
        }
        
        return asText.contains(".") ?  asText : (asText + ".")
    }
}



enum FontSize: CGFloat {
    
    case title = 26
    case subtite = 22
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
