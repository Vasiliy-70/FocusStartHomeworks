//
//  ArrayInteracting.swift
//  Lessons2_ThreadSafeArray
//
//  Created by Admin on 25.10.2020.
//

final class ArrayInteracting<Element> {
    
    private var threadSafeArray = ThreadSafeArray<Element>()
    
    func addItem(_ item: Element, amount: Int) {
        print("\nЗапись в массив")
        for number in 0...amount {
            print("Добавление \(number) элемента: \(item)")
            self.threadSafeArray.append(item)    
        }
    }
    
    func remove(at index: Int) {
        self.threadSafeArray.remove(at: index)
    }
        
    func printArray() {
        print("Считывание массива")
        
        if self.threadSafeArray.isEmpty {
            print("Массив пуст!")
        }
        else {
            for index in 0..<self.threadSafeArray.count {
                self.getItem(index)
            }
        }
    }
    
    func getItem(_ index: Int) {
        print(self.threadSafeArray[index] ?? "Элемент не найден")
    }
}

extension ArrayInteracting where Element: Equatable {
    func contains(_ element: Element) {
        let string = self.threadSafeArray.contains(element) ? "Есть такой" : "Нет такого"
        print(string)
    }
}
