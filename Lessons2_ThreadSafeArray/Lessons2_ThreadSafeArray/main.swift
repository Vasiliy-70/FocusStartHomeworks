//
//  main.swift
//  Lessons2_ThreadSafeArray
//
//  Created by Admin on 25.10.2020.
//
import Foundation

var array = ArrayInteracting<String>()

let queue = DispatchQueue.global(qos: .userInitiated)

// Проверка параллельной записи в потокобезопасный массив
queue.async {
    array.addItem("\u{1F608}", amount: 1000)
}
queue.async {
    array.addItem("\u{1F600}", amount: 1000)
}
sleep(1)

// Вывод результата
queue.async {
    array.printArray()
}
sleep(1)

// Проверка наличия элемента в массиве
queue.sync {
    array.contains("\u{1F600}")
}

_ = readLine()

