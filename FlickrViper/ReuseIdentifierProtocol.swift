//
//  ReuseIdentifierProtocol.swift
//  FlickrViper
//
//  Created by Игорь Талов on 30.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

public protocol ReuseIdentifierProtocol: class {
    //Get Identifier from class
    static var defaultReuseIdentifier: String { get }
}

public extension ReuseIdentifierProtocol where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
