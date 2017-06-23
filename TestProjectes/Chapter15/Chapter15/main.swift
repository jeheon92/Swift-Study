//
//  main.swift
//  Chapter15
//
//  Created by Jeheon Choi on 2017. 6. 19..
//  Copyright © 2017년 JeheonChoi. All rights reserved.
//

import Foundation

// 코드 15-9 친구들의 정보 생성
enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: Array<Friend> = [Friend]()

friends.append(Friend(name: "Yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "JiSoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender: .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender: .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))


// 코드 15-10 조건에 맞는 친구 결과 출력 (위 코드는 작년에 입력된 자료라고 가정)
// 서울 외의 지역에 거주하며 25세 이상인 친구
var result: [Friend] = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }
result = result.filter{ $0.location != "서울" && $0.age >= 25 }
let string: String = result.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") { $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"}

print(string)
// 서울 외의 지역에 거주하며 25세 이상인 친구
// Yoobato male 발리 27세
// JiSoo male 시드니 25세
// JuHyun male 경기 31세
// JungKi unknown 대전 30세
// YoungMin male 경기 25세



// 당근 이렇게 연결해서도 사용가능하다고 생각했으나.....
// Compile error 발생! 뭐지..?
// Expression was too complex to be solved in reasonable time; consider breaking up the expression into distinct sub-expressions

//var string = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }.filter{ $0.location != "서울" && $0.age >= 25 }.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") { $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세" }

// ㅋㅋㅋㅋ 좀 느리긴해도 이건 됨ㅋㅋㅋㅋㅋㅋ 뭐지 진짜?
// 문자열 살짝 합침
//var string = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }.filter{ $0.location != "서울" && $0.age >= 25 }.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") { $0 + "\n\($1.name) \($1.gender) \($1.location) \($1.age)세" }


print("\n" + string)



