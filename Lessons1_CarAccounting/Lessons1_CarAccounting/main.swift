//
//  main.swift
//  Lessons1_CarAccounting
//
//  Created by Admin on 16.10.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

// MARK: Вид заголовков
let mainTitle = """

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

let catalogTitle = """

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
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
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
    
    print("Введите производителя")
    let manufacturer = getInputStream(optional: false) ?? "NotCorrect"
    
    print("Введите модель")
    let model = getInputStream(optional: false) ?? "NotCorrect"
    
    let body = getBodyType()
    
    print("Введите год выпуска")
    let year = Int(getInputStream(optional: true) ?? "")
    
    print("Введите госномер")
    let number = getInputStream(optional: true)
    
    carArray.append(Car(manufacturer: manufacturer, model: model, body: body, yearOfIssue: year, carNumber: number))
}

// MARK: Функция вывода списка автомобилей
func getList(cars: [Car]) {
    var notMatch = true
    
    print(catalogTitle)
    for item in cars {
        print("""
            Производитель: \(item.manufacturer)
            Модель: \(item.model)
            Тип кузова: \(item.body.rawValue)
            """)
        if let year = item.yearOfIssue {
            print("Год выпуска: \(year)")
        } else {
            print("Год выпуска: -")
        }
        if let number = item.carNumber, number != "" {
            print ("Госномер: \(number)")
        }
        print("__________________________________")
        notMatch = false
    }
    
    if (notMatch) {
        print("Каталог пуст!")
    }
    
    print("\nНажмите любую клавишу")
    _ = readLine();
}

// MARK: Функция вывода списка с фильтром по кузову
func getListSortedBy(bodyType: Body) {
    var carList = [Car]()
    
    for item in carArray where item.body.rawValue == bodyType.rawValue {
        carList.append(item)
    }
    
    getList(cars: carList)
}

var carArray = [Car]()

// MARK: Добавление автомобилей по умолчанию
carArray.append(Car(manufacturer: "Toyota", model: "Allion", body: Body.sedan, yearOfIssue: 2009, carNumber: "Г445НУ"))
carArray.append(Car(manufacturer: "Niva", model: "Urban", body: Body.offRoad, yearOfIssue: nil, carNumber: nil))

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
        getList(cars: carArray)
    // Вывод каталога с фильтром по кузову
    case "3":
        getListSortedBy(bodyType: getBodyType())
    default: break
    }
} while inputString != "q"
print("Всего хорошего!")
