//
//  Weak.swift
//  Pods
//
//  Created by Tatsuya Tobioka on 1/24/16.
//
//

import Foundation

class Weak<T: AnyObject> {
  weak var value: T?
  init(value: T) {
    self.value = value
  }
}
