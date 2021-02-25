//
//  ViewController.swift
//  LinkedInScraper
//
//  Created by Trevor Carpenter on 2/24/21.
//

import UIKit
import Foundation
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var TextLabel: UITextView!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var WebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WebView.navigationDelegate = self
    }
    
    func searchForString(left: String, right: String, total: String) -> String? {
        guard let leftSideString = total.range(of: left) else {
            print("couldn't find it")
            return nil
        }
        let leftOnward = total[leftSideString.lowerBound...String.Index(utf16Offset: (total.count-1), in: total)]
        guard let rightSideString = leftOnward.range(of: right) else {
            print("couldn't find right side")
            return nil
            
        }
        
        let valueWeWantToGrab = leftOnward[leftOnward.startIndex...rightSideString.upperBound]
        
        return String(valueWeWantToGrab)
    }
    
    func parseHTML(HTML htmlString: String) {
        print("\n")
        let qualificationHTML = searchForString(left: "Preferred qualifications:<br><ul>", right: "</ul>", total: htmlString) ?? ""
        let qualifications = qualificationHTML.split(separator: ">", maxSplits: 10, omittingEmptySubsequences: true)
//        let badCharacters: Set<Character> = ["<", "/", ">"]
        self.TextLabel.text = "Preferred Qualifications:"
        for i in 1...(qualifications.count-1) {
            let q = qualifications[i]
            let len = q.count
            
            if len > 4 {
                self.TextLabel.text.append("\n- \(q.dropLast(3))")
            }
        }
    }
    
    // runs when the WebView is done
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var str = ""
        self.WebView.evaluateJavaScript("document.body.innerHTML", completionHandler: { html, error in
            if let htmlString = html as? String {
                str = htmlString
                if str.contains("show-more-less-html__button--more") {
                    self.WebView.evaluateJavaScript("document.getElementsByClassName('show-more-less-html__button--more')[0].click()", completionHandler: { html, error in
                        self.WebView.evaluateJavaScript("document.body.innerHTML", completionHandler: { html, error in
                            if let htmlString = html as? String{
                                self.parseHTML(HTML: htmlString)
                            } else {
                                print("Nothing?")
                            }
                        })
                    })
                } else {
                    print("no button")
                }
            } else {
                print("Nothing?")
            }
        })
        
        
    }
    
    @IBAction func goPressed(_ sender: Any) {
        guard let url = URL(string: URLTextField.text ?? "") else {
            print("Text Field Error")
            return
        }
        
        let myRequest = URLRequest(url: url)
        WebView.load(myRequest)
    }
    
}

