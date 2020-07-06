//
//  DetailViewController.swift
//  AsurionTask
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var selectedModel:PetModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedModel?.title
        webView.load(URLRequest(url: URL(string: selectedModel!.contentUrl)!))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
