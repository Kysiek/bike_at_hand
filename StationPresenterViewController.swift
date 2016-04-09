//
//  StationPresenterViewController.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class StationPresenterViewController: UIViewController {

    internal var stations: [Station]!
    internal var filteredStations: [Station]!
    internal var searchController: UISearchController!
    
    var userAPI: UserAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchController()
    }
    
    func initializeSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["All stations", "With bikes"]
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    internal func searchStationsContainingTextAndUpdateView(searchString: String, scope: Int) {
            filteredStations = Station.filterStations(stations, containingText: searchString, andMayBeEmpty: scope == 0)
    }

}
extension StationPresenterViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            searchStationsContainingTextAndUpdateView(searchString, scope: searchController.searchBar.selectedScopeButtonIndex)
        }
    }
}
extension StationPresenterViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResultsForSearchController(searchController)
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        updateSearchResultsForSearchController(searchController)
    }
}