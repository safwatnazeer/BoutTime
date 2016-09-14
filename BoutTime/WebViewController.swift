//
//  WebViewController.swift
//  BoutTime
//
//  Created by Safwat Shenouda on 14/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class WebViewController: UIViewController , UIWebViewDelegate {
    
    
    var link:String?
    
    //outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let link = self.link {
            let url = NSURL(string: link)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            webView.delegate = self
            activityIndicator.startAnimating()
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func closeWebView() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    }
