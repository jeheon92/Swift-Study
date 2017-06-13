# Chapter14 옵셔널 체이닝과 빠른종료  
> 옵셔널 체이닝이 없다면 옵셔널은 정말로 귀찮고 또 귀찮은 존재  

## 14.1 옵셔널 체이닝  
> 옵셔널을 반복 사용하여 옵셔널이 자전거 체인처럼 서로 꼬리를 물고있는 모양이기 때문에 옵셔널 체이닝이라고 부릅니다.  

- 옵셔널 변수나 상수 뒤에 물음표(?)를 붙여 표현합니다.  
- 옵셔널이 nil이 아니라면 정상적으로 호출될 것이고, nil이라면 결괏값으로 nil을 반환합니다.  
  
  > 결과적으로 nil이 반환될 가능성이 있으므로 옵셔널 체이닝의 반환된 값은 항상 옵셔널입니다.  

  > 옵셔널 강제추출(!)은 추출하고자 하는 옵셔널이 nil일때 오류 발생! 100%  
  > 강제추출(!)은 nil이 아니라는 확신을 하더라도 사용을 지양하는 편이 좋습니다.

	```swift
	// 코드14-1 사람의 주소정보 표현 설계
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
	
	
	// 코드 14-2 인스턴스 생성
	let jeheon: Person = Person(name: "jeheon")
	
	
	// 코드 14-3 옵셔널 체이닝 문법!!
	let jeheonRoomViaOptionalChaining: Int? = jeheon.address?.building?.room?.number		// nil
	let jeheonRoomViaOptionalUnwraping: Int! = jeheon.address!.building!.room!.number		// 오류 발생!!  
	```  


- 옵셔널 바인딩과 옵셔널 체이닝은 환상의 궁합을 자랑합니다.  

  	```swift  
  	// 코드 14-4 옵셔널 바인딩'만' 사용
  	let yagom: Person = Person(name: "yagom")
	var roomNumber: Int? = nil
	
	if let yagomAddress: Address = yagom.address {
	    if let yagomBuilding: Building = yagomAddress.building {
	        if let yagomRoom: Room = yagomBuilding.room {
	            roomNumber = yagomRoom.number
	        }
	    }
	}
		
	if let number: Int = roomNumber {
	    print(number)   
	} else {
	    print("Can not find room number")
	}
	   
	
	// 코드 14-5 옵셔널 체이닝의 사용 (+ 옵셔널 바인딩)
	let yagom: Person = Person(name: "yagom")
	
	if let roomNumber: Int = yagom.address?.building?.room?.number {
	    print(roomNumber)
	} else {
	    print("Can not find room number")
	}
	
	// 이렇게 "옵셔널 체이닝 + 옵셔널 바인딩"으로 표현하는게 훨씬 간단해집니다.
	
	```

- 옵셔널 체이닝을 통해 메서드와 서브스크립트 호출도 가능합니다. (메서드의 반환 타입이 옵셔널일 경우)  



### Q. 그렇다면 그냥 '옵셔널'이랑 '암시적 추출 옵셔널'이랑은 대체 무슨 차이가 있는 걸까?    
  > 둘 다 nil을 가질 수 있고, nil일 때 호출해도 오류발생 안한다. 뭐가 다르지?  

- 암시적 추출 옵셔널은 제대로 된 옵셔널 체이닝이 안된다.  
  
  ```swift  
  // 먼저 위 예제 코드 중 address, building, room를
  // 암시적 추출 옵셔널로 선언 (선언 부분은 생략)
  
  print(jeheon.address)		// nil
  print(jeheon.address.building.room.number)		// 오류 발생!
  // nil의 프로퍼티를 접근! 당연히 런타임 에러 발생
  
  
  // 암시적 추출 옵셔널에 옵셔널 체이닝을 하면?
  // Warning 발생.. 동작 동일(?)하게 하기는 함. 
  print(jeheon.address?.building?.room?.number)	// nil
  ```


## 14.2 빠른 종료  
**빠른종료**의 핵심 키워드는 **guard** 
if 구문과는 다르게 guard 구문은 항상 else 구문이 뒤에 따라와야 한다.   

```swift
guard Bool 타입 값 else {
	예외상황 실행문
	제어문 전환 명령어
}
```