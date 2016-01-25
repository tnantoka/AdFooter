//
//  AdFooterViewController.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/27/15.
//
//

import UIKit

import GoogleMobileAds
import iAd

class AdFooterViewController: UIViewController, ADBannerViewDelegate, GADBannerViewDelegate {
    
    let originalController: UIViewController
    let withIAd: Bool
    
    var iAd = Ad<ADBannerView>()
    var adMob = Ad<GADBannerView>()
    
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
    
    init(originalController: UIViewController, withIAd: Bool) {
        self.originalController = originalController
        self.withIAd = withIAd
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
            if iAd.shown {
                bannerView = iAd.view
            } else if adMob.shown {
                bannerView = adMob.view
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
            withIAd ? createIAd() : createAdMob()
        }
    }

    func removeAd() {
        removeIAd()
        removeAdMob()
    }

    func createIAd() {
        let bannerView = ADBannerView(adType: .Banner)
        bannerView.delegate = self
        view.addSubview(bannerView)
        iAd.view = bannerView
    }

    func removeIAd() {
        iAd.shown = false
        iAd.view?.delegate = self
        iAd.view?.removeFromSuperview()
    }

    func createAdMob() {
        let bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
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
    
    // MARK: - ADBannerViewDelegate

    func bannerViewDidLoadAd(banner: ADBannerView!) {
        removeAdMob()
        if !hidden {
            iAd.shown = true
        }
        view.setNeedsLayout()
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        iAd.shown = false
        
        createAdMob()
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
