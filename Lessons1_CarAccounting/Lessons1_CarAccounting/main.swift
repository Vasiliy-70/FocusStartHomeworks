//
//  main.swift
//  Lessons1_CarAccounting
//
//  Created by Admin on 16.10.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

// MARK: Вид заголовков
var mainTitle = """

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
Главное меню
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

Введите нужную команду и нажмите Enter
1 - Добавить автомобиль
2 - Вывести список автомобилей
3 - Вывести список автомобилей с выбранным типом кузова
q - Выход

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

"""

var catalogTitle = """

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
Каталог авто
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

"""

// MARK: Инициализация типов кузова
enum Body: String {
    case hatchback = "Хэтчбек"
    case minivan = "Минивэн"
    case sedan = "Седан"
    case offRoad = "Внедорожник"
    case unknown
}

// MARK: Инициализация структуры автомобиль
struct Car {
    var manufacturer: String
    var model: String
    var body: Body
    var yearOfIssue: Int?
    var carNumber: String?
}

// MARK: Функция считывания ввода с клавиатуры
func getInputStream(optional: Bool) -> String? {
    var inputString: String?
    
    if (optional) {
        return readLine()
    }
    
    repeat {
        inputString = readLine() ?? ""
    } while inputString == ""
    return inputString
}

// MARK: Функция выбора типа кузова
func getBodyType() -> Body {
    var inputString: String?
    var body = Body.unknown
    
    print("""
        Выберите тип кузова:
        1 - Хэтчбек
        2 - Минивэн
        3 - Седан
        4 - Внедорожник
        """)
    
    while body == Body.unknown {
        inputString = readLine() ?? ""
        switch (inputString) {
        case "1": body = Body.hatchback
        case "2": body = Body.minivan
        case "3": body = Body.sedan
        case "4": body = Body.offRoad
        default:  break
        }
    }
    return body
}

// MARK: Функция добавления автомобиля в список
func addCar() {
    print("Добавление автомобиля")
    print("Введите производителя"); let manufacturer = getInputStream(optional: false) ?? "NotCorrect";
    print("Введите модель"); let model = getInputStream(optional: false) ?? "NotCorrect";
    let body = getBodyType()
    print("Введите год выпуска"); let year = Int(getInputStream(optional: true) ?? "");
    print("Введите госномер"); let number = getInputStream(optional: true);
    carArray.append(Car(manufacturer: manufacturer, model: model, body: body, yearOfIssue: year, carNumber: number))
}

// MARK: Функция вывода списка автомобилей
func getCarList(list: [Car]) {
    var notMatch = true
    
    print(catalogTitle)
    for car in list {
        print("""
            Производитель: \(car.manufacturer)
            Модель: \(car.model)
            Тип кузова: \(car.body.rawValue)
            """)
        if let year = car.yearOfIssue {
            print("Год выпуска: \(year)")
        } else {
            print("Год выпуска: -")
        }
        if let number = car.carNumber, number != "" {
            print ("Госномер: \(number)")
        }
        print("__________________________________")
        notMatch = false
    }
    if (notMatch) {
        print("Каталог пуст!")
    }
    print("\nНажмите любую клавишу")
}

// MARK: Функция вывода списка с фильтром по кузову
func bodyTypeSorting(bodyType: Body) {
    var carList = [Car]()
    for car in carArray where car.body.rawValue == bodyType.rawValue {
        carList.append(car)
    }
    getCarList(list: carList)
}

var carArray = [Car]()

// MARK: Добавление автомобилей по умолчанию
carArray.append(Car(manufacturer: "Toyota", model: "Allion", body: Body.sedan, yearOfIssue: 2009, carNumber: "Г445НУ"))
carArray.append(Car(manufacturer: "Niva", model: "Urban", body: Body.offRoad))

// MARK: Реализация пользовательского интерфейса
var inputString : String
repeat {
    print(mainTitle)
    inputString = getInputStream(optional: false) ?? ""
    switch (inputString) {
    // Добавление автомобиля
    case "1": addCar()
    // Вывод каталога
    case "2":
        getCarList(list: carArray)
        _ = readLine()
    // Вывод каталога с фильтром по кузову
    case "3":
        bodyTypeSorting(bodyType: getBodyType())
        _ = readLine()
    default: break
    }
} while inputString != "q"
print("Всего хорошего!")
