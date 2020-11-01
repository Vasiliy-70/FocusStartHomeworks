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
        return self.array.isEmpty
    }
    var count: Int {
        return self.array.count
    }
    
    private let isolationQueue = DispatchQueue(label: "com.threadSaveArray.isolation",
                                               qos: .userInitiated,
                                               attributes: .concurrent)
    
    func append(_ item: Element) {
        self.isolationQueue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    func remove(at index: Int) {
        self.isolationQueue.async(flags: .barrier) {
            self.array.remove(at: index)
        }
    }
    
    subscript(index: Int) -> Element? {
        var item: Element? = nil

        self.isolationQueue.sync {
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
        return self.array.contains(element)
    }
}
