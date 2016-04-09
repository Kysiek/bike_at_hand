//
//  StationListController.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 17/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class StationListViewController: StationPresenterViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var stationListDataSource: StationListDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = self.searchController.searchBar
        
        userAPI.getStations({ stationArray in
            
                self.stations = stationArray
                self.stationListDataSource.dataSource = self.stations
                self.callFunctionInMainThread {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.tableView.hidden = false
                }
            },
            error: { message in
                self.callFunctionInMainThread {
                    self.showAlert(message, cancellationHandler: nil)
                }
            })
    }
    
    override func searchStationsContainingTextAndUpdateView(searchString: String, scope: Int) {
        super.searchStationsContainingTextAndUpdateView(searchString, scope: scope)
        stationListDataSource.dataSource = filteredStations
        tableView.reloadData()
        
    }
    

}
