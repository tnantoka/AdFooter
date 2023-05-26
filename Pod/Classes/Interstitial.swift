//
//  Interstitial.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2017/04/30.
//
//

import Foundation

import GoogleMobileAds

open class Interstitial: NSObject {
    public static let shared = Interstitial()

    open var adMobAdUnitId = ""

    private var adMob: GADInterstitialAd?
    private var loaded = false

    open func load() {
        guard !adMobAdUnitId.isEmpty && !loaded else { return }

        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adMobAdUnitId,
                                    request: request,
                          completionHandler: { (ad, error) in

                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            self.adMob = ad
                            self.adMob?.fullScreenContentDelegate = self
                          })
        loaded = true
    }

    open func present(for viewController: UIViewController) {
        guard let adMob = adMob else { return }
        
        do {
            try adMob.canPresent(fromRootViewController: viewController)
            adMob.present(fromRootViewController: viewController)
        } catch {
            print("error")
        }
    }
}

extension Interstitial: GADFullScreenContentDelegate {
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loaded = false
        load()
    }
}
