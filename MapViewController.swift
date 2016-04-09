//
//  MapViewController.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class MapViewController: StationPresenterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        stations = userAPI.getRecentlyDownloadedStations()
    }
    
//    func willPresentSearchController(searchController: UISearchController){
//        
//         self.navigationController!.navigationBar.translucent = true;
//    }
//    
//    func willDismissSearchController(searchController: UISearchController){
//        
//        self.navigationController!.navigationBar.translucent = false;
//    }
}
