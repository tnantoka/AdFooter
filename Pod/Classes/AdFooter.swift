//
//  AdFooter.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/27/15.
//
//

import UIKit

public class AdFooter {
    public static let shared = AdFooter()
    
    public var adMobAdUnitId = ""
    public var hidden = false {
        didSet {
            controllers.forEach { $0.value?.hidden = hidden }
        }
    }
    
    var controllers = [Weak<AdFooterViewController>]()
    
    public func wrap(originalController: UIViewController) -> UIViewController {
        let adFooterController = AdFooterViewController(originalController: originalController)
        adFooterController.hidden = hidden
        controllers.append(Weak(value: adFooterController))
        return adFooterController
    }
}