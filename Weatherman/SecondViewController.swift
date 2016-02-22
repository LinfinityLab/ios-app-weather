//
//  SecondViewController.swift
//  Weatherman
//
//  Created by Weifan Lin on 2/18/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

var favoredList = [String]()

class SecondViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var favoredCitiesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoredList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell:")
        
        cell.textLabel?.text = favoredList[indexPath.row]
        return cell
        
    }
    
    override func viewDidAppear(animated: Bool) {
        favoredCitiesTable.reloadData()
    }

}