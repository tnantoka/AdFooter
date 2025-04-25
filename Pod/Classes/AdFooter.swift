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
    
    open var adMobAdUnitId = ""
    open var hidden = false {
        didSet {
            controllers.forEach { $0.value?.hidden = hidden }
        }
    }
    open var paused = false {
        didSet {
            controllers.forEach { $0.value?.paused = paused }
        }
    }
    open var debugGDPR = true

    public let interstitial = Interstitial()

    private var controllers = [Weak<AdFooterViewController>]()
    private var started = false

    open func start(callback: @escaping () -> Void) {
        if started {
            callback()
        } else {
            MobileAds.shared.start { _ in
                callback()
            }
        }
    }

    open func wrap(_ originalController: UIViewController) -> UIViewController {
        let adFooterController = AdFooterViewController(originalController: originalController)
        adFooterController.hidden = hidden
        controllers.append(Weak(value: adFooterController))
        return adFooterController
    }
}
