//
//  main.swift
//  SwiftTest
//
//  Created by Jeheon Choi on 2017. 5. 23..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

import Foundation

// Int 외의 다른 자료형도 마찬가지
// 일단, Warning 무시
var variable1 = 3
var variable2: Int! = 3     // 암시적 추출 옵셔널
var variable3: Int? = 3     // 옵셔널

print("// Test 1 --------------------//")
print(variable1)            // 3
print(variable2)            // 3
print(variable3)            // Optional(3)


print("\n\n// Test 2 --------------------//")
print("\(variable1)")       // 3
print("\(variable2)")       // Optional(3)
print("\(variable3)")       // Optional(3)


print("\n\n// Test 3 --------------------//")
print(Optional(variable1))  // Optional(3)
print(Optional(variable2))  // Optional(Optional(3))
print(Optional(variable3))  // Optional(Optional(3))
print(Optional(variable3)!)     // Optional(Optional(3))!
print(Optional(variable3)!!)    // Optional(Optional(3))!!


print("\n\n// Test 4 --------------------//")
print(variable1 == variable3)               // Warning 안뜨는 이유? (값 추출이 아닌, 통째로 비교?)
print(Optional(variable1) == variable3)


print("\n\n// Test 5 --------------------//")
switch variable2 {
case .none:
    print("nil")
case .some(let some):
    print(some)
}

switch variable3 {
case .none:
    print("nil")
case .some(let some):
    print(some)
}


print("\n\n// Test 6 --------------------//")
var variable4: Int?
print(variable4)    // 내부적으로 variable4 ?? nil로 처리 되는건가?
//print(variable4!)   // runtime error




// 그 외
print("\n\n// etc tests -----------------//")
enum Numbers: Int {
    case zero
    case one
    case two
    case ten = 10
}

print(Numbers.two.rawValue)
print(Optional.none ?? "왜 rawValue 없음?")  // 왜 rawValue 없음?



//print(nil)      // 불가능
let testNil: Int! = nil
print(testNil)  // 이건 왜 가능? : 옵셔널 자료형만 nil 수용가능

var errorTest: Int?
//print(errorTest!)	// 런타임 에러



print("\n\n// Binding Test -----------------//")
var bindingTest: Int?

if var i: Int = bindingTest {
    print(i)
} else {
    print("else")
}

if var j: Int? = bindingTest {
    print(j)
} else {
    print("else")
}

var k: Int = bindingTest    // error

