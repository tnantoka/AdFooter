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

    private var adMob: InterstitialAd?
    private var loaded = false

    open func load() {
        guard !adMobAdUnitId.isEmpty && !loaded else { return }

        let request = Request()
        InterstitialAd.load(with: adMobAdUnitId,
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
            try adMob.canPresent(from: viewController)
            adMob.present(from: viewController)
        } catch {
            print("error")
        }
    }
}

extension Interstitial: FullScreenContentDelegate {
    public func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        loaded = false
        load()
    }
}
