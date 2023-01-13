//
//  ViewController.swift
//  AdFooter
//
//  Created by tnantoka on 11/27/2015.
//  Copyright (c) 2015 tnantoka. All rights reserved.
//

import UIKit

import AdFooter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AdFooter.shared.interstitial.load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleButtonDidTap(_ sender: AnyObject) {
        AdFooter.shared.hidden = !AdFooter.shared.hidden
    }

    @IBAction func pauseButtonDidTap(_ sender: AnyObject) {
        AdFooter.shared.paused = !AdFooter.shared.paused
    }

    @IBAction func interstitialButtonDidTap(_ sender: Any) {
        AdFooter.shared.interstitial.present(for: self)
    }
}

