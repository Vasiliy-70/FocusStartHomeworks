//
//  CommandController.swift
//  Lessons1_CarAccounting
//
//  Created by Admin on 24.10.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

final class CommandController {
    
    private enum Constants {
        static let incorrectValueMessage = "Введённое значение неверно"
    }
    
    func readString() -> String {
        var string = ""
        if let inputString = readLine(),
           inputString != "" {
            string = inputString
        }
        else {
            print("\(Constants.incorrectValueMessage)\n")
            return self.readString()
        }
        return string
    }
    
    func readOptionalString() -> String? {
        let inputString = readLine()
        if inputString?.isEmpty ?? true {
            return nil
        }
        return inputString
    }
    
    func readInt() -> Int {
        if let int = Int(self.readString()) {
            return int
        }
        else {
            print("\(Constants.incorrectValueMessage)\n")
            return self.readInt()
        }
    }
    
    func readOptionalInt() -> Int? {
        if let inputString = self.readOptionalString() {
            if let int = Int(inputString) {
                return int
            }
            else {
                print("\(Constants.incorrectValueMessage)\n")
                return self.readOptionalInt()
            }
        }
        else {
            return nil
        }
    }
    
    func readBody() -> Body {
        let inputInt = self.readInt()
        
        if let body = Body(rawValue: inputInt) {
            return body
        } else {
            print("\(Constants.incorrectValueMessage)\n")
            return self.readBody()
        }
    }
}

