//
//  Timestamp+Ext.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 04/03/24.
//

import Foundation
import Firebase

extension Timestamp: Comparable {
    public static func < (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.dateValue() < rhs.dateValue()
    }
}
