//
//  main.swift
//  Chapter14
//
//  Created by Jeheon Choi on 2017. 6. 13..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

import Foundation

// 코드 14-1 사람의 주소정보 표현 설계
class Room {    // 호실
    var number: Int             // 호실 번호
    
    init(number: Int) {
        self.number = number
    }
}

class Building {    // 건물
    var name: String           // 건물이름
    var room: Room?	   // 호실정보
    
    init(name: String) {
        self.name = name
    }
}

struct Address {    // 주소
    var province: String        // 광역시/도
    var city: String            // 시/군/구
    var street: String          // 도로명
    var building: Building?     // 건물
    var detailAddress: String?  // 건물 외 상세주소
}

class Person {  // 사람
    var name: String            // 이름
    var address: Address?       // 주소
    
    init(name: String) {
        self.name = name
    }
}

// 코드 14-5 옵셔널 체이닝의 사용
let yagom: Person = Person(name: "yagom")

if let roomNumber: Int = yagom.address?.building?.room?.number {
    print(roomNumber)
} else {
    print("Can not find room number")
}

//// 코드 14-6 옵셔널 체이닝을 통한 값 할당 시도
yagom.address?.building?.room?.number = 505
print(yagom.address?.building?.room?.number)	// nil


// 코드 14-7 옵셔널 체이닝을 통한 값 할당
yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로", building: nil, detailAddress: nil)
yagom.address?.building = Building(name: "곰굴")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505

print(yagom.address?.building?.room?.number)    // Optional(505)

//print(yagom.address?.building?.room?.number!)       // error
//print((yagom.address?.building?.room?.number)!)     // 505


let jeheon: Int? = Int()
