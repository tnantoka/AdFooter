//
//  AdFooterViewController.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/27/15.
//
//

import UIKit

import GoogleMobileAds

class AdFooterViewController: UIViewController, GADBannerViewDelegate {
    
    let originalController: UIViewController
    
    var adMob = Ad<GADBannerView>()
    
    var adMobSize: GADAdSize {
        return UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication().statusBarOrientation) ? kGADAdSizeSmartBannerPortrait : kGADAdSizeSmartBannerLandscape
    }
    
    var hidden = false {
        didSet {
            if !hidden {
                createAd()
            } else {
                removeAd()
                view.setNeedsLayout()
            }
        }
    }
    
    init(originalController: UIViewController) {
        self.originalController = originalController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = .blackColor()
        
        addChildViewController(originalController)
        view.addSubview(originalController.view)
        
        self.view = view
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createAd()
    }
    
    override func viewDidLayoutSubviews() {
        var contentFrame = view.frame
        
        if !hidden {
            var bannerView: UIView?
            if adMob.shown {
                bannerView = adMob.view
                
                if let adMobView = adMob.view {
                    adMobView.adSize = adMobSize
                }
            }
            if let bannerView = bannerView {
                contentFrame.size.height -= CGRectGetHeight(bannerView.frame)
                bannerView.frame.origin.y = CGRectGetHeight(contentFrame)
                view.bringSubviewToFront(bannerView)
            }
        }
        
        originalController.view.frame = contentFrame
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return originalController.preferredStatusBarStyle()
    }

    // MARK: - Utility
    
    func createAd() {
        removeAd()
        if !hidden {
            createAdMob()
        }
    }

    func removeAd() {
        removeAdMob()
    }

    func createAdMob() {
        let bannerView = GADBannerView(adSize: adMobSize)
        bannerView.delegate = self
        view.addSubview(bannerView)
        adMob.view = bannerView
        
        bannerView.adUnitID = AdFooter.shared.adMobAdUnitId
        bannerView.rootViewController = self
        let req = GADRequest()
        req.testDevices = [kGADSimulatorID]
        bannerView.loadRequest(req)
    }

    func removeAdMob() {
        adMob.shown = false
        adMob.view?.delegate = self
        adMob.view?.removeFromSuperview()
    }
    
    // MARK: - GADBannerViewDelegate
    
    func adViewDidReceiveAd(bannerView: GADBannerView!) {
        if !hidden {
            adMob.shown = true
        }
        view.setNeedsLayout()
    }
    
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        adMob.shown = false
    }
}
