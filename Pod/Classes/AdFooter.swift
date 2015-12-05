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
    
    public func wrap(originalController: UIViewController) -> UIViewController {
        let adFooterController = AdFooterViewController(originalController: originalController)
        return adFooterController
    }
}