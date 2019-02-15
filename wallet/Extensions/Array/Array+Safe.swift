//
//  Array+Safe.swift
//  lisca
//
//  Created by Ciprian Cojan on 28/02/2018.
//  Copyright © 2018 Rawfish. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return (Int(index) >= 0 && Int(index) < count) ? self[Int(index)] : nil
    }
    
    mutating func safeRemove(at index: Int) {
        guard (index >= 0 && index < count) else { return }
        remove(at: index)
    }
    
    mutating func safeInsert(_ newElement: Element, at i: Int) {
        guard (i >= 0 && i <= count) else { return }
        insert(newElement, at: i)
    }
}


