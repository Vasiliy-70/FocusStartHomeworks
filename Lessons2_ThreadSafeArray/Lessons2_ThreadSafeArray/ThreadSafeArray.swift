//
//  ThreadSafeArray.swift
//  Lessons2_ThreadSafeArray
//
//  Created by Admin on 25.10.2020.
//

import Foundation

final class ThreadSafeArray<Element> {
    private var array = [Element]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    var count: Int {
        return array.count
    }
    
    private let isolationQueue = DispatchQueue(label: "com.threadSaveArray.isolation",
                                               qos: .userInitiated,
                                               attributes: .concurrent)
    
    func append(_ item: Element) {
        isolationQueue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    func remove(at index: Int) {
        isolationQueue.async(flags: .barrier) {
            self.array.remove(at: index)
        }
    }
    
    func subscriptAt(index: Int) -> Element? {
        var item: Element? = nil

        isolationQueue.sync {
            guard index >= 0 && index < self.count else {
                return
            }
            
            item = self.array[index]
        }
        return item
    }
}

extension ThreadSafeArray where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        return array.contains(element)
    }
}
