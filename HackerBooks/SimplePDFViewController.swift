//
//  SimplePDFViewController.swift
//  HackerBooks
//
//  Created by CLAG on 1/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

import UIKit

class SimplePDFViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    var model : NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadData(model!, MIMEType: "application/pdf", textEncodingName: "", baseURL: NSURL())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
