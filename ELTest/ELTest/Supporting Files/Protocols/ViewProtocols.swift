//
//  ViewProtocols.swift
//  ELTest
//
//  Created by Omar Gonzalez on 27/10/22.
//

import UIKit

protocol DataCellViewModable {
  var reuseIdentifier: String { get }
}

protocol CustomConfigurableCell {
  func setup(with data: DataCellViewModable)
}

typealias NibReusable = Reusable & NibLoadable

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

protocol NibLoadable: AnyObject {
  static var nib: UINib { get }
}

extension NibLoadable {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

extension UITableView {

  func registerReusable<T: UITableViewCell>(cell: T.Type) where T: NibReusable {
    self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
  }

  func registerReusable<T: UITableViewCell>(cell: T.Type) where T: Reusable {
    self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }

  func registerReusableHeader<T: UITableViewHeaderFooterView>(cell: T.Type) where T: NibReusable {
    self.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
  }
  func registerReusableHeader<T: UITableViewHeaderFooterView>(cell: T.Type) where T: Reusable {
    self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
    return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
  }
}

