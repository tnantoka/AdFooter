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

    private var adMob: GADInterstitial?
    private var loaded = false

    open func load() {
        guard !adMobAdUnitId.isEmpty && !loaded else { return }

        adMob = GADInterstitial(adUnitID: adMobAdUnitId)
        adMob?.delegate = self
        let request = GADRequest()
        adMob?.load(request)
        loaded = true
    }

    open func present(for viewController: UIViewController) {
        if adMob?.isReady ?? false {
            adMob?.present(fromRootViewController: viewController)
        }
    }
}

extension Interstitial: GADInterstitialDelegate {
    public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        load()
    }
}
