//
//  ListTableViewController.swift
//  OnTheMap
//
//  Created by SDK on 2/11/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var studentLocations = [StudentLocation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentLocations = Common.sharedInstance.studentLocation
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        let student = self.studentLocations[(indexPath.row)]
        
        cell.textLabel?.text = "\(student.firstName ?? "N/A") \(student.lastName ?? "N/A")"
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
}
