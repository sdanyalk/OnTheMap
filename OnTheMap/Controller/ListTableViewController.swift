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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = self.studentLocations[(indexPath.row)]
        
        if let mediaUrl = student.mediaURL {
            let app = UIApplication.shared
            
            app.open(URL(string: mediaUrl)!, options: [:], completionHandler: nil)
        }
    }
}
