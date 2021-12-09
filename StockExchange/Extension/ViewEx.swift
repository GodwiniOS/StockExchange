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
        backgroundColor = color.asColor()
    }
    

}



extension UITableView {

    func registerCell() {
        self.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
//        self.register(CollapsibleTableViewCell.self, forCellReuseIdentifier: "CollapsibleTableViewCell")
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
        
//        let paragraph = NSMutableParagraphStyle()
//        paragraph.alignment = .center
        
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
        

        
        
        // if you want, you can add more attributes for different ranges calling .setAttributes many times

        // set the attributed string to the UILabel object
        
        attributedText = amountText
    }
}


extension Int {
    var text : String {
        return "\(self)"
    }
}

extension Double {
    var text : String {
        return "\(self)"
    }
}



enum FontSize: CGFloat {
    
    case title = 24
    case subtite = 10
}


//enum ViewControllerType: String {
//    case upcoming
//    case top_rated
//
//    var title: String {
//        switch self {
//        case .upcoming: return "Upcoming Movies"
//        case .top_rated: return "Top Rated Movies"
//        }
//    }
//}

//var viewControllerType : ViewControllerType? = nil

//enum AppTitle: String {
//
//    case topRatedMovieTitle    = "Top Rated Movies"
//    case upComingMovieTitle    = "Upcoming Movies"
//}
