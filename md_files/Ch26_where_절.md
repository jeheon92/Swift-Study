# Chapter26 where 절  
where 절은 특정 패턴과 결합하여 조건을 추가하는 역할을 한다.  

## 26.1 where 절의 활용  
where 절은 크게 두 가지 용도로 사용된다.  

- 패턴과 결합하여 조건 추가  
- 타입에 대한 제약 추가  

### 값 바인딩, 와일드카드 패턴과 결합
```swift
// 코드 26-1 값 바인딩, 와일드카드 패턴과 where 절의 활용
let tuples: [(Int, Int)] = [(1, 2), (1, -1), (1, 0), (0, 2)]

// 값 바인딩, 와일드카드 패턴
for tuple in tuples {
    switch tuple {
    case let (x, y) where x == y: print("x == y")
    case let (x, y) where x == -y: print("x == -y")
    case let (x, y) where x > y: print("x > y")
    case (1, _): print("x == 1")
    case (_, 2): print("y == 2")
    default: print("\(tuple.0), \(tuple.1)")
    }
}
/*
 x == 1
 x == -y
 x > y
 y == 2
 */


var repeatCount: Int = 0
// 값 바인딩 패턴
for tuple in tuples {
    switch tuple {
    case let (x, y) where x == y && repeatCount > 2: print("x == y")
    case let (x, y) where repeatCount < 2: print("\(x), \(y)")
    default: print("Nothing")
    }
    
    repeatCount += 1
}
/*
 1, 2
 1, -1
 Nothing
 Nothing
 */


let firstValue: Int = 50
let secondValue: Int = 30

// 값 바인딩 패턴
switch firstValue + secondValue {
case let total where total > 100: print("total > 100")
case let total where total < 0: print("wrong value")
case let total where total == 0: print("zero")
case let total: print(total)
}   // 80
```  


### 옵셔널 패턴과 결합  

```swift
// 코드 26-2 옵셔널 패턴과 where 절의 활용
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

for case let number? in arrayOfOptionalInts where number > 2 {
    print("Found a \(number)")
}
// Found a 3
// Found a 5
```  


### 타입캐스팅 패턴과 결합  

```swift
// 코드 26-3 타입캐스팅 패턴과 where 절의 활용
let anyValue: Any = "ABC"

switch anyValue {
case let value where value is Int: print("value is Int")
case let value where value is String: print("value is String")
case let value where value is Double: print("value is Double")
default: print("Unknown type")
}    // value is String

var things: [Any] = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// Hello, Michael
```  


### 표현 패턴과 결합  

```swift
// 코드 26-4 표현 패턴과 where 절의 활용
var point: (Int, Int) = (1, 2)

switch point {
case (0, 0): print("원점")
case (-2...2, -2...2) where point.0 != 1: print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
default: print("point (\(point.0), \(point.1))")
}   // point (1, 2)
```  

### 프로토콜 익스텐션의 프로토콜 준수 제약 추가  
익스텐션이 적용된 프로토콜을 준수하는 타입 중에 where 절 뒤에 제시되는 프로토콜도 준수하는 타입만 익스텐션이 적용되도록 제약을 줄 수 있다.  

여러 프로토콜을 제시하고 싶다면 쉼표로 구분해주면 된다.  

```swift
// 코드 26-5 where 절을 활용한 프로토콜 익스텐션의 프로토콜 준수 제약 추가
protocol SelfPrintable {
    func printSelf()
}

struct Person: SelfPrintable { }

extension Int: SelfPrintable { }
extension UInt: SelfPrintable { }
extension String: SelfPrintable { }
extension Double: SelfPrintable { }

extension SelfPrintable where Self: Integer, Self: Comparable {
    func printSelf() {
        print("Integer와 Comparable을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}

extension SelfPrintable where Self: CustomStringConvertible {
    func printSelf() {
        print("CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}

extension SelfPrintable {
    func printSelf() {
        print("그 외 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}

Int(-8).printSelf()         // Integer와 Comparable을 준수하면서 SelfPrintable을 준수하는 Int 타입
UInt(8).printSelf()         // Integer와 Comparable을 준수하면서 SelfPrintable을 준수하는 UInt 타입
String("yagom").printSelf() // CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 String 타입
Double(8.0).printSelf()     // 그 외 SelfPrintable을 준수하는 타입 Double
Person().printSelf()        // 그 외 SelfPrintable을 준수하는 타입 Person()
```

### 타입 매개변수와 연관 타입의 타입 제약 추가  
제네릭의 where 절을 사용한 요구사항  
요구사항이 여러 개일 때는 쉼표로 구분한다.  

```swift
// 코드 26-6 where 절을 활용한 타입 매개변수와 연관 타입의 타입 제약 추가
// 타입 매개변수 T가 Integer 프로토콜을 준수하는 타입
func doubled<T>(integerValue: T) -> T where T: Integer {
    return integerValue * 2
}

// 위 함수와 같은 표현입니다.
func doubled<T: Integer>(integerValue: T) -> T {
    return integerValue * 2
}

// 타입 매개변수 T와 U가 CustomStringConvertible 프로토콜을 준수하는 타입
func prints<T, U>(first: T, second: U) where T: CustomStringConvertible, U: CustomStringConvertible {
    print(first)
    print(second)
}

// 위 함수와 같은 표현입니다.
func prints<T: CustomStringConvertible, U: CustomStringConvertible>(first: T, second: U) {
    print(first)
    print(second)
}


// 타입 매개변수 S1과 S2가 Sequence 프로토콜을 준수하며
// S1과 S2가 준수하는 프로토콜인 Sequence 프로토콜의 연관 타입인 SubSequence가 서로 같은 타입
func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S1.SubSequence: Equatable, S2: Sequence, S2.SubSequence: Equatable {
    // ...
}

// 위 함수와 같은 표현입니다
func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S2: Sequence, S1.SubSequence: Equatable, S1.SubSequence == S2.SubSequence {
    // ...
}

// 위 함수와 같은 표현입니다
func compareTwoSequences<S1: Sequence, S2: Sequence>(a: S1, b: S2) where S1.SubSequence: Equatable, S1.SubSequence == S2.Iterator.Element {
    // ...
}
```
