//
//  SecondViewController.swift
//  Weatherman
//
//  Created by Weifan Lin on 2/18/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

var favoredList = [String]()

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chosenCellIndex = 0
    @IBOutlet weak var favoredCitiesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        if (NSUserDefaults.standardUserDefaults().objectForKey("array") != nil) {
            favoredList = NSUserDefaults.standardUserDefaults().objectForKey("array") as! [String]
        } else {
            favoredList = [String]()
            NSUserDefaults.standardUserDefaults().setObject(favoredList, forKey: "array")
        }
        
        NSUserDefaults.standardUserDefaults().setObject(favoredList, forKey: "array")
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            favoredList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(favoredList, forKey: "array")
            favoredCitiesTable.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        favoredCitiesTable.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //let object : AnyObject?
        chosenCellIndex = indexPath.row
        
//        print (indexPath.row)

        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destinationViewController as! DetailViewController

       
            detailViewController.receivedCellIndex = chosenCellIndex

        
        }
    }

}