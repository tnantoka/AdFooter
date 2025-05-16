//
//  AdFooterViewController.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/27/15.
//
//

import AppTrackingTransparency
import GoogleMobileAds
import UIKit
import UserMessagingPlatform

class AdFooterViewController: UIViewController {

  private let originalController: UIViewController

  fileprivate var adMob = Banner<BannerView>()

  var hidden = false {
    didSet {
      if oldValue == hidden {
        return
      }

      if !hidden {
        createBanner()
      } else {
        removeBanner()
        view.setNeedsLayout()
      }
    }
  }

  var paused = false {
    didSet {
      if paused {
        pausedShown = adMob.shown
        adMob.shown = false
      } else {
        adMob.shown = pausedShown
      }
    }
  }
  var pausedShown = false

  init(originalController: UIViewController) {
    self.originalController = originalController
    super.init(nibName: nil, bundle: nil)
  }

  override func loadView() {
    let view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .black

    addChild(originalController)
    view.addSubview(originalController.view)

    self.view = view
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if adMob.view == nil {
      requestTracking { [weak self] in
        AdFooter.shared.start {
          self?.createBanner()
          AdFooter.shared.interstitial.load()
        }
      }
    }
  }

  override func viewDidLayoutSubviews() {
    var contentFrame = view.frame

    let inset: CGFloat
    if #available(iOS 11.0, *) {
      inset = UIApplication.shared.windows[0].safeAreaInsets.bottom
    } else {
      inset = 0.0
    }
    contentFrame.size.height -= inset

    if !hidden {
      var bannerView: UIView?
      if adMob.shown {
        bannerView = adMob.view

        if let adMobView = adMob.view {
          adMobView.adSize = getFullWidthAdaptiveAdSize()
        }
      }
      if let bannerView = bannerView {
        contentFrame.size.height -= bannerView.frame.height
        bannerView.frame.origin.y = contentFrame.height
        view.bringSubviewToFront(bannerView)
      }
    }

    originalController.view.frame = contentFrame
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
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
    let bannerView = BannerView(adSize: getFullWidthAdaptiveAdSize())
    bannerView.delegate = self
    view.addSubview(bannerView)
    adMob.view = bannerView

    bannerView.adUnitID = AdFooter.shared.adMobAdUnitId
    bannerView.rootViewController = self
    let req = Request()
    bannerView.load(req)
  }

  private func removeAdMob() {
    adMob.shown = false
    adMob.view?.delegate = self
    adMob.view?.removeFromSuperview()
  }

  private func requestTracking(callback: @escaping () -> Void) {
    if UIApplication.shared.applicationState != .active {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
        self?.requestTracking(callback: callback)
      }
      return
    }

    requestGDPR { [weak self] in
      self?.requestIDFA(callback: callback)
    }
  }

  private func requestIDFA(callback: @escaping () -> Void) {
    if #available(iOS 14, *) {
      ATTrackingManager.requestTrackingAuthorization { _ in
        DispatchQueue.main.async {
          callback()
        }
      }
    } else {
      callback()
    }
  }

  private func requestGDPR(callback: @escaping () -> Void) {
    let parameters = RequestParameters()
    parameters.isTaggedForUnderAgeOfConsent = false

    #if DEBUG
      if AdFooter.shared.debugGDPR {
        let debugSettings = DebugSettings()
        debugSettings.geography = .EEA
        parameters.debugSettings = debugSettings
      }
    #endif

    ConsentInformation.shared.requestConsentInfoUpdate(with: parameters) {
      [weak self] requestConsentError in
      guard let self else { return }
      guard requestConsentError == nil else { return }

      ConsentForm.loadAndPresentIfRequired(from: self) { loadAndPresentError in
        guard loadAndPresentError == nil else { return }

        if ConsentInformation.shared.canRequestAds {
          callback()
        }
      }

      if ConsentInformation.shared.canRequestAds {
        callback()
      }
    }
  }

  func getFullWidthAdaptiveAdSize() -> AdSize {
    let frame = { () -> CGRect in
      if #available(iOS 11.0, *) {
        return view.frame.inset(by: view.safeAreaInsets)
      } else {
        return view.frame
      }
    }()
    return currentOrientationAnchoredAdaptiveBanner(width: frame.size.width)
  }
}

extension AdFooterViewController: BannerViewDelegate {
  func bannerViewDidReceiveAd(_ bannerView: BannerView) {
    if !hidden {
      adMob.shown = true
    }
    view.setNeedsLayout()
  }

  func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
    adMob.shown = false
  }
}
