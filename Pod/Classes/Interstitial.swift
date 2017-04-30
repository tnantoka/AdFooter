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
    open static let shared = Interstitial()

    open var adMobAdUnitId = ""

    private var adMob: GADInterstitial?

    open func load() {
        adMob = GADInterstitial(adUnitID: adMobAdUnitId)
        adMob?.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adMob?.load(request)
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
