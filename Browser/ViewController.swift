//
//  ViewController.swift
//  Browser
//
//  Created by Елизавета Щербакова on 24.02.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let homePage = "https://www.google.ru"
        textField.text = homePage
        
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true // перемещение между страницами с помощью свайпа
        
        textField.delegate = self
        webView.navigationDelegate = self
        
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
        
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        let urlString = textField.text!
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        textField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
