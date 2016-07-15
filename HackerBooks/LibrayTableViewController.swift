//
//  LibrayTableViewController.swift
//  HackerBooks
//
//  Created by CLAG on 1/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController, LibraryDelegate{
    
    var model : Library?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let strFilePath = documents.stringByAppendingString("books_readable.json");
        do {
            guard let _ = defaults.valueForKey("bookReader") else {
                defaults.setBool(true, forKey: "bookReader")
                let urlString = "https://t.co/K9ziV0z3SJ"
                
                if let urlJSON = NSURL(string: urlString), let data = NSData(contentsOfURL: urlJSON){
                    data.writeToFile(strFilePath, atomically: true)
                    try createModel(data);
                }
                
                return
            }
            if let data = NSData(contentsOfFile: strFilePath){
                try createModel(data)
            }
            
        } catch {
            fatalError()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (model?.countTags)!
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.sortedTagsList[section].capitalizedString
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.countBooksForSection(section))!
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> BookTableViewCell {
        
        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("BookTableViewCell") as! BookTableViewCell
        
        let book = model?.getBook(indexPath.section, index: indexPath.row)
        cell.titleLabel.text = book?.title
        cell.subTitleLabel.text = book?.authors.joinWithSeparator(", ")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // performSegueWithIdentifier("showBook", sender: self)
    
    }
    
    func createModel(data: NSData) throws{
        if let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray {
            model = Library(collection: decode (booksCollection: json))
            print(model)
        }
    }
    
    // MARK: - Seques
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBook"{
            let bookVC = segue.destinationViewController as?  BookViewController
            let pk = self.tableView.indexPathForSelectedRow
            let book = model?.getBook((pk?.section)!, index: (pk?.row)!)
            bookVC?.delegate = self
            bookVC?.model = book
        }
    }
    
    func modifiedFavouriteValue(value: Bool, book: Book, controller: BookViewController){
        self.model?.setFavourite(value, book: book);
        self.tableView?.reloadData()
    
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    
    }
}

// MARK: - Protocol

protocol LibraryDelegate
{
    func modifiedFavouriteValue(value: Bool, book: Book, controller: BookViewController)

}


