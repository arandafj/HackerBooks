//
//  BookViewController.swift
//  HackerBooks
//
//  Created by CLAG on 1/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var switchElement: UISwitch!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var itemFavourite: UIBarButtonItem!
    
    var delegate : LibraryDelegate? = nil
    var model : Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = model?.title
        authorsLabel.text = model?.authors.joinWithSeparator(", ")
              
        if let _ = model?.image{
            if let img = UIImage(data: (model?.image)!){
                image.image = img
            }
        }
        
        let index = model?.tags.indexOf("Favourite")
        if (index >= 0){
            model?.tags.removeAtIndex(index!)
            switchElement.setOn(true, animated: true)
            
        } else{
            switchElement.setOn(false, animated: true)
        }
        tagsLabel.text = model?.tags.joinWithSeparator(", ")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func  viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        checkSwitch()
    }
    
    
    @IBAction func switchChange(sender: AnyObject) {
        checkSwitch()
    }
    
    // MARK: - Seques
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPDF"{
            let pdfVC = segue.destinationViewController as? SimplePDFViewController
            pdfVC?.model = model?.pdf
            
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    // MARK: - Utility
    
    func checkSwitch() {
        
        var isFavourite :Bool
        if switchElement.on {
            switchElement.setOn(true, animated:true)
            model?.tags.insert("Favourite", atIndex: 0)
            isFavourite = true;
        } else {
            switchElement.setOn(false, animated:true)
            model?.tags.removeAtIndex(0)
            isFavourite = false
        }
        
        delegate!.modifiedFavouriteValue(isFavourite, book: model!, controller:self)
        
    }
    
}

