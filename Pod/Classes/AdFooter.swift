//
//  AdFooter.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/27/15.
//
//

import UIKit

import GoogleMobileAds

open class AdFooter {
    public static let shared = AdFooter()
    
    open var adMobApplicationId = "" {
        didSet {
            GADMobileAds.configure(withApplicationID: adMobAdUnitId)
        }
    }
    open var adMobAdUnitId = ""
    open var hidden = false {
        didSet {
            controllers.forEach { $0.value?.hidden = hidden }
        }
    }
    public let interstitial = Interstitial()

    private var controllers = [Weak<AdFooterViewController>]()

    open func wrap(_ originalController: UIViewController) -> UIViewController {
        let adFooterController = AdFooterViewController(originalController: originalController)
        adFooterController.hidden = hidden
        controllers.append(Weak(value: adFooterController))
        return adFooterController
    }
}
