//
//  Rewarded.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 2025/05/14.
//

import Foundation

import GoogleMobileAds

open class Rewarded: NSObject {
    public static let shared = Rewarded()

    open var adMobAdUnitId = ""

    private var adMob: RewardedAd?
    private var loaded = false
    private var earned = false
    private var didEarn: () -> Void = {}
    private var didCancel: () -> Void = {}
    private var didFail: (Error) -> Void = { _ in }

    open func load(didFail: @escaping (Error) -> Void) {
        guard !adMobAdUnitId.isEmpty && !loaded else { return }

        let request = Request()
        RewardedAd.load(with: adMobAdUnitId, request: request) { ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                didFail(error)
                return
            }
            self.adMob = ad
            self.adMob?.fullScreenContentDelegate = self
        }
        loaded = true
    }

    open func present(for viewController: UIViewController, didEarn: @escaping () -> Void, didCancel: @escaping () -> Void, didFail:  @escaping (Error) -> Void) {
        guard let adMob = adMob else { return }

        self.didEarn = didEarn
        self.didCancel = didCancel
        self.didFail = didFail
        
        do {
            try adMob.canPresent(from: viewController)
            adMob.present(from: viewController) {
                self.earned = true
            }
        } catch {
            print("error")
        }
    }
    
    private func reset() {
        self.adMob = nil
        self.loaded = false
        self.didEarn = {}
        self.didCancel = {}
        self.didFail = { _ in }
    }
}

extension Rewarded: FullScreenContentDelegate {
    public func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        let earned = self.earned
        let didEarn = self.didEarn
        let didCancel = self.didCancel
        reset()

        if (earned) {
            didEarn()
        } else {
            didCancel()
        }
    }
    
    public func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        reset()
        didFail(error)
    }
}
