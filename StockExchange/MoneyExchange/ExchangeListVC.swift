//
//  ViewController.swift
//  StockExchange
//
//  Created by Godwin A on 09/12/21.
//

import UIKit

class ExchangeListVC: UIViewController {

    // MARK: - Properties
    var exchangelistTV = UITableView()
    var exchangeListVM = ExchangeListViewModel()

    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }

    private func prepareView() {
        

        
        
        // prepare ListTable
        view.addSubview(exchangelistTV)
        exchangelistTV.prepareLayout(.top,constant: topbarHeight())
        exchangelistTV.prepareLayout(.bottom)
        exchangelistTV.prepareLayout(.leading)
        exchangelistTV.prepareLayout(.trailing)
        exchangelistTV.registerCell()
        exchangelistTV.delegate = self
        exchangelistTV.dataSource = self
        exchangelistTV.separatorStyle = .none
    }

}


extension ExchangeListVC: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exchangeListVM.exchangeValues.count + 1
    }


    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let exchangeTVC = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        if indexPath.row == 0,indexPath.section == 0 {
            exchangeTVC.prepareCell()
        } else {
            exchangeTVC.prepareCell(exchangeListVM.exchangeValues[indexPath.row - 1])
        }
        return exchangeTVC
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


