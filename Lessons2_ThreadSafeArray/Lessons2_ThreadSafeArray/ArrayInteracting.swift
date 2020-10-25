//
//  ArrayInteracting.swift
//  Lessons2_ThreadSafeArray
//
//  Created by Admin on 25.10.2020.
//

import Foundation

final class ArrayInteracting<Element> {
    
    private var threadSafeArray = ThreadSafeArray<Element>()
    
    func addItem(_ item: Element, amount: Int) {
        print("Запись в массив")
        for number in 0...amount {
            print("Добавление \(number) элемента: \(item)")
            self.threadSafeArray.append(item)    
        }
    }
    
    func remove(at index: Int) {
        print("Введите номер удаляемого элемента")
        self.threadSafeArray.remove(at: index)
    }
    
    func getItem(at index: Int) {
        print("Введите номер элемента")
        self.threadSafeArray.remove(at: index)
    }
    
    func printArray() {
        print("Считывание массива")
        for index in 0..<self.threadSafeArray.count {
            self.getItem(index)
        }
    }
    
    func getItem(_ index: Int) {
        print(self.threadSafeArray.subscriptAt(index: index) ?? "item isn't found")
    }
}
