//
//  StationListController.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 17/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class StationListViewController: UIViewController {
    
    var userAPI: UserAPI!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var stationListDataSource: StationListDataSource!
    
    private var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchController()
        
        userAPI.getStations({stationArray in
            self.stationListDataSource.dataSource = stationArray
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.tableView.hidden = false
            })
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func searchStationsContainingText(searchString: String, scope: Int) {
        
    }
    
    func initializeSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["All stations", "With bikes"]
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = self.searchController.searchBar
        definesPresentationContext = true
    }
    
}
extension StationListViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            searchStationsContainingText(searchString, scope: searchController.searchBar.selectedScopeButtonIndex)
            tableView.reloadData()
        }
    }
}
extension StationListViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResultsForSearchController(searchController)
    }
}