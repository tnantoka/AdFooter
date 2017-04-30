//
//  AdFooterViewController.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/27/15.
//
//

import UIKit

import GoogleMobileAds

class AdFooterViewController: UIViewController {
    
    private let originalController: UIViewController
    
    fileprivate var adMob = Banner<GADBannerView>()
    
    private var adMobSize: GADAdSize {
        return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation) ? kGADAdSizeSmartBannerPortrait : kGADAdSizeSmartBannerLandscape
    }
    
    var hidden = false {
        didSet {
            if !hidden {
                createBanner()
            } else {
                removeBanner()
                view.setNeedsLayout()
            }
        }
    }
    
    init(originalController: UIViewController) {
        self.originalController = originalController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        
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
        createBanner()
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
                contentFrame.size.height -= bannerView.frame.height
                bannerView.frame.origin.y = contentFrame.height
                view.bringSubview(toFront: bannerView)
            }
        }
        
        originalController.view.frame = contentFrame
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return originalController.preferredStatusBarStyle
    }

    // MARK: - Utility
    
    private func createBanner() {
        removeBanner()
        if !hidden {
            createAdMob()
        }
    }

    private func removeBanner() {
        removeAdMob()
    }

    private func createAdMob() {
        let bannerView = GADBannerView(adSize: adMobSize)
        bannerView.delegate = self
        view.addSubview(bannerView)
        adMob.view = bannerView
        
        bannerView.adUnitID = AdFooter.shared.adMobAdUnitId
        bannerView.rootViewController = self
        let req = GADRequest()
        req.testDevices = [kGADSimulatorID]
        bannerView.load(req)
    }

    private func removeAdMob() {
        adMob.shown = false
        adMob.view?.delegate = self
        adMob.view?.removeFromSuperview()
    }
}

extension AdFooterViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        if !hidden {
            adMob.shown = true
        }
        view.setNeedsLayout()
    }

    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adMob.shown = false
    }
}
