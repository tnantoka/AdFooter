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
        loadRewarded()
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

    @IBAction func rewardedButtonDidTap(_ sender: Any) {
        AdFooter.shared.rewarded.present(for: self) { [weak self] in
            self?.showAlert(message: "Reward earned")
            self?.loadRewarded()
        } didCancel: { [weak self] in
            self?.loadRewarded()
        } didFail: { [weak self] error in
            self?.showAlert(message: error.localizedDescription)
        }
    }
    
    private func loadRewarded() {
        AdFooter.shared.rewarded.load { [weak self] error in
            self?.showAlert(message: error.localizedDescription)
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: message,
            message: nil,
            preferredStyle: .alert
        )

        alertController.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: ""),
                style: .default
            )
        )

        present(alertController, animated: true)
    }
}

