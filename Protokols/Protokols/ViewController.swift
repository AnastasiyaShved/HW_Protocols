//
//  ViewController.swift
//  Protokols
//
//  Created by Apple on 4.09.23.
//

import UIKit

//MARK: - Protocols -
protocol SomeProtocol {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}

struct SomeStruct: SomeProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    func getSum() -> Int {
        return self.mustBeSettable + self.doesNotNeedToBeSettable
    }
}

protocol AnotheProtocol {
    static var someTypeProperty: Int {get}
}
struct AnotherStruct: SomeProtocol, AnotheProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    static var someTypeProperty: Int = 3
    func getSum() -> Int {
        return self.mustBeSettable + self.doesNotNeedToBeSettable + AnotherStruct.someTypeProperty
    }
}
// пример  объявления  протокола, содержащего требование к реализации методов

protocol RandomNumberGenerator {
    var randomCollection: [Int] { get set }
    func getRandomNumber() -> Int
    mutating func setNewRandomCollection(newValue: [Int])
}

//  пример  создания структуры и класса, принимаюзих протокол RandomNumberGenerator

struct RandomGenerator: RandomNumberGenerator {
    var randomCollection: [Int] = [1, 2, 3, 4, 5]
    
    func getRandomNumber() -> Int {
        return randomCollection.randomElement() ?? 0
    }
    
    mutating func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

class RandomGeneratorClass: RandomNumberGenerator {
   var randomCollection: [Int] = [1, 2, 3, 4, 5]
    
    func getRandomNumber() -> Int {
        if let randomElement = randomCollection.randomElement() {
            return randomElement
        }
        return 0
    }
    func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

// реализация протокола с требованием к реализации инициализатора
protocol Named {
    init(name: String)
}

class Person: Named {
    var name: String
    required init(name: String) {
        self.name = name
    }
}

// протокол, указывающий на множество типов

func getHash<T: Hashable>(of value: T) -> Int {
    return value.hashValue
}

// протокол и as! as?

protocol HasValue {
    var value: Int { get set }
}

class ClasswithValue: HasValue {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

struct StructWithValue: HasValue {
    var value: Int
}

let objects: [Any] = [ 2, StructWithValue(value: 3), true, ClasswithValue(value: 6), "Usov" ]

func func1(){
    for object in objects {
        if let elementWithValue = object as? HasValue {
            print("Значение \(elementWithValue.value)")
        }
    }
}

// протокол и is

func func2() {
    for object in objects {
            print(object is HasValue)
    }
}
// наследование протоколов
protocol GeometricFigureWithXAxis {
    var x: Int { get set }
}

protocol GeometricFigureWithYAxis {
    var y: Int { get set }
}

protocol GeometricFigureWithTwoAxis: GeometricFigureWithXAxis, GeometricFigureWithYAxis {
    var distanceFromCenter: Float { get }
}

struct Figure2D: GeometricFigureWithTwoAxis {
    var x: Int = 0
    var y: Int = 0
    var distanceFromCenter: Float {
        let xpow = pow(Double(self.x), 2)
        let ypow = pow(Double(self.y), 2)
        let length = sqrt(xpow + ypow)
        return Float(length)
    }
}

//классовые протоколы
protocol SuperProtocol { }
protocol SubProtocol: AnyObject, SuperProtocol { }

class ClassWithProtocol: SubProtocol { }

//  композиция протоколов
protocol Name1 {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person1: Name1, Aged {
    var name: String
    var age: Int
}
func HappyBirthday(celebrator: Name1 & Aged) {
    print("С Днем рождения, \(celebrator.name)! Тебе уже \(celebrator.age)")
}
let bertPer = Person1(name: "Jon", age: 55)
//HappyBirthday(celebrator: bertPer)

