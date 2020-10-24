//
//  CarListApp.swift
//  Lessons1_CarAccounting
//
//  Created by Admin on 24.10.2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import Foundation

final class CarListApp {
    private let controller = CommandController()
    private var cars = [Car]()
    
    func startApp() {
        self.addDefaultCars()
        
        while true {
            self.printMenu()
            let inputString = readLine()
            
            switch (inputString) {
            case "1":
                self.addCar()
            case "2":
                self.printCars()
            case "3":
                self.printCarsWithBody()
            case "q":
                exit(0)
            default:
                print("\nПовторите попытку\n")
                break
            }
        }
    }
}

private extension CarListApp {
    func printMenu() {
        print("""
            Введите нужную команду и нажмите Enter
            1 - Добавить автомобиль
            2 - Вывести список автомобилей
            3 - Вывести список автомобилей с выбранным типом кузова
            q - Выход
            """)
    }
    
    func addCar() {
        print("Введите производителя")
        let manufacturer = self.controller.readString()
        
        print("Введите модель")
        let model = self.controller.readString()
        
        print("Выберите тип кузова:")
        let body = self.readBody()
        
        print("Введите год выпуска")
        let yearOfIssue = self.controller.readOptionalInt()
        
        print("Введите госномер")
        let carNumber = self.controller.readOptionalString()
        
        self.cars.append(Car(manufacturer: manufacturer, model: model, body: body, yearOfIssue: yearOfIssue, carNumber: carNumber))
    }
    
    func readBody() -> Body {
        var bodyIndex = 1
        
        print("Доступные корпуса:")
        for body in Body.allCases{
            print("\(bodyIndex) - \(body.name)")
            bodyIndex += 1
        }
        
        return self.controller.readBody()
    }
    
    func printCars() {
        for (index, car) in self.cars.enumerated() {
            self.printCar(car, atIndex: index)
            print("")
        }
        
        let _ = readLine()
    }
    
    func printCarsWithBody() {
        let body = self.readBody()
        
        for (index, car) in self.cars.enumerated() where body == car.body {
            self.printCar(car, atIndex: index)
            print("")
        }
        
        let _ = readLine()
    }
    
    func printCar(_ car: Car, atIndex index: Int) {
        print("Каталожный номер: \(index + 1)")
        print("Производитель: \(car.manufacturer)")
        print("Модель: \(car.model)")
        print("Тип кузова: \(car.body.name)")
        print("Год выпуска: \(car.yearOfIssue?.description ?? "-")")
        
        if let number = car.carNumber {
            print("Гоcномера: \(number)")
        }
    }
    
    func addDefaultCars() {
        self.cars.append(Car(manufacturer: "Toyota", model: "Allion", body: Body.sedan, yearOfIssue: 2009, carNumber: "Г445НУ"))
        self.cars.append(Car(manufacturer: "Niva", model: "Urban", body: Body.offRoad, yearOfIssue: nil, carNumber: nil))
    }
}
