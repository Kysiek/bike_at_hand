//
//  StationListDataSource.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 17/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class StationListDataSource: NSObject,UITableViewDataSource {
    
    var dataSource: [Station]?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource != nil ? dataSource!.count : 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stationCellView")
        cell?.textLabel!.text = dataSource?[indexPath.row].name
        return cell!
    }
}
