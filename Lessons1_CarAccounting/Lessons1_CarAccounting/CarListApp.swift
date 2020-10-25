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
        
        while true {
            self.printMenu()
            let inputString = readLine()
            
            switch (inputString) {
            case "1":
                self.addCar()
            case "2":
                self.printCarList()
            case "3":
                self.printCarListWithBody()
            case "4":
                self.addDefaultCars()
            case "5":
                self.clearCarList()
            case "q":
                print("Всего хорошего!")
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
            4 - Добавить автомобили по умолчанию
            5 - Очистить список автомобилей
            _______________________________________________________
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
        
        print("Автомобиль добавлен")
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
    
    func printCarList() {
        var listIsEmpty = true
        
        for (index, car) in self.cars.enumerated() {
            self.printCarInfo(car, atIndex: index)
            listIsEmpty = false
            print("")
        }
        
        if listIsEmpty {
            print("Список автомобилей пуст!")
            print("Нажмите 1, чтобы добавить автомобили по умолчанию")
            if let inputString = self.controller.readOptionalString(),
               inputString == "1" {
                self.addDefaultCars()
            }
        }
        else {
            self.waitUserAction()
        } 
    }
    
    func printCarListWithBody() {
        var listIsEmpty = true
        let body = self.readBody()
        
        for (index, car) in self.cars.enumerated() where body == car.body {
            self.printCarInfo(car, atIndex: index)
            listIsEmpty = false
            print("")
        }
        
        if (listIsEmpty) {
            print("Список автомобилей пуст!")
        }
        
        self.waitUserAction()
    }
    
    func printCarInfo(_ car: Car, atIndex index: Int) {
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
        print("Список автомобилей обновлён!")
    }
    
    func clearCarList() {
        cars.removeAll()
        print("Список автомобилей очищен")
    }
    
    func waitUserAction() {
        print("Нажмите любую клавишу для продолжения")
        let _ = readLine()
    }
}
