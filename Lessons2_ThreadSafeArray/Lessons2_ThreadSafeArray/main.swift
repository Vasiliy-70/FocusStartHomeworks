//
//  main.swift
//  Lessons2_ThreadSafeArray
//
//  Created by Admin on 25.10.2020.
//
import Foundation

var app = ArrayInteracting<String>()

let queue = DispatchQueue.global(qos: .userInitiated)
queue.async {
    app.addItems("s")
}
sleep(1)
queue.async {
    app.printArray()
}

_ = readLine()
