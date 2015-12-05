//
//  Ad.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 11/30/15.
//
//

struct Ad<T: UIView> {
    var shown = false {
        didSet {
            view?.hidden = !shown
        }
    }
    var view: T? {
        didSet {
            view?.hidden = true
        }
    }
}